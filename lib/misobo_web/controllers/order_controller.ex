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
      response(conn, 400, %{
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

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
