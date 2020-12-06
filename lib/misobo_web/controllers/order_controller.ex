defmodule MisoboWeb.OrderController do
  @moduledoc """
  This module defines the Order releated stuff
  """
  use MisoboWeb, :controller
  alias Misobo.Accounts.User
  alias Misobo.Transactions
  alias Misobo.Transactions.{Transaction, Order}

  def create(%{assigns: %{user: %User{id: user_id}}} = conn, %{"amount" => amount} = params) do
    with receipt <- Misobo.Commons.generate_receipt(),
         transaction_params <-
           Transactions.transaction_params(user_id, amount, receipt),
         {:ok, %Transaction{} = tranaction} <-
           Misobo.Transactions.create_transaction(transaction_params),
         order_params <- Transactions.order_params(amount, receipt, params["notes"]),
         {:ok, pg_resp} <- Transactions.create_pg_order(order_params),
         pg_order_params <- pg_resp |> Map.put("pg_order_id", pg_resp["id"]),
         {:ok, %Order{id: order_id, pg_order_id: pg_order_id} = _order} <-
           Transactions.create_order(pg_order_params),
         {:ok, %Transaction{id: transaction_id}} <-
           Transactions.update_transaction(tranaction, %{order_id: order_id, status: "ORDER"}) do
      response(conn, 200, %{
        data: %{
          pg_order_id: pg_order_id,
          transaction_id: transaction_id,
          order_id: order_id
        }
      })
    else
      {:error, "PG call failed" = msg} ->
        response(conn, 400, %{data: msg})

      {:error, _error_resp} ->
        response(conn, 400, %{data: "error"})
    end
  end

  def capture(
        %{assigns: %{user: %User{id: user_id}}} = conn,
        %{
          "payment_id" => payment_id,
          "signature" => signature,
          "order_id" => order_id,
          "transaction_id" => transaction_id,
          "amount" => amount
        } = _params
      ) do
    %Transaction{} = transaction = Transactions.get_transaction(transaction_id)
    %Order{amount: order_amount} = order = Transactions.get_order(order_id)

    {code, status} =
      with true <- amount * 100 == order_amount,
           {:ok, %Transaction{} = _transaction} <-
             Transactions.update_transaction(transaction, %{status: "INITATED_CAPTURE"}),
           {:ok, %Order{} = _order} <-
             Transactions.update_order(order, %{
               status: "INITATED_CAPTURE",
               signature: signature,
               payment_id: payment_id
             }),
           :success <- Transactions.initiate_capture(payment_id, order_amount) do
        {200, "success"}
      else
        false ->
          {400, "failed"}

        :failed ->
          {400, "failed"}

        {:error, _error} ->
          {400, "failed"}

        _ ->
          {400, "failed"}
      end

    %Transaction{} = transaction = Transactions.get_transaction(transaction_id)
    %Order{id: ord_id, notes: notes} = order = Transactions.get_order(order_id)

    case {code, status} do
      {200, _status} ->
        Transactions.update_transaction(transaction, %{status: "COMPLETED"})
        Transactions.update_order(order, %{status: "COMPLETED"})

        # Fetch packs
        case Misobo.Packs.get_pack(notes["package"]) do
          nil ->
            ""

          %Misobo.Packs.Pack{karma_coins: coins} ->
            Misobo.Accounts.add_karma(user_id, coins, "BUY_PACK:order_#{ord_id}")
        end

        response(conn, code, %{data: %{msg: "Success"}})

      _ ->
        Transactions.update_transaction(transaction, %{status: "FAILED"})
        Transactions.update_order(order, %{status: "FAILED"})
        response(conn, code, %{data: %{msg: "failed to caputre payment"}})
    end
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
