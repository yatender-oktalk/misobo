defmodule Misobo.TransactionsTest do
  use Misobo.DataCase

  alias Misobo.Transactions

  describe "orders" do
    alias Misobo.Transactions.Order

    @valid_attrs %{
      amount: 42,
      amount_due: 42,
      amount_paid: 42,
      attempts: 42,
      created_at: 42,
      currency: "some currency",
      entity: "some entity",
      notes: %{},
      offer_id: "some offer_id",
      receipt: "some receipt",
      status: "some status"
    }
    @update_attrs %{
      amount: 43,
      amount_due: 43,
      amount_paid: 43,
      attempts: 43,
      created_at: 43,
      currency: "some updated currency",
      entity: "some updated entity",
      notes: %{},
      offer_id: "some updated offer_id",
      receipt: "some updated receipt",
      status: "some updated status"
    }
    @invalid_attrs %{
      amount: nil,
      amount_due: nil,
      amount_paid: nil,
      attempts: nil,
      created_at: nil,
      currency: nil,
      entity: nil,
      notes: nil,
      offer_id: nil,
      receipt: nil,
      status: nil
    }

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Transactions.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Transactions.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Transactions.create_order(@valid_attrs)
      assert order.amount == 42
      assert order.amount_due == 42
      assert order.amount_paid == 42
      assert order.attempts == 42
      assert order.created_at == 42
      assert order.currency == "some currency"
      assert order.entity == "some entity"
      assert order.notes == %{}
      assert order.offer_id == "some offer_id"
      assert order.receipt == "some receipt"
      assert order.status == "some status"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Transactions.update_order(order, @update_attrs)
      assert order.amount == 43
      assert order.amount_due == 43
      assert order.amount_paid == 43
      assert order.attempts == 43
      assert order.created_at == 43
      assert order.currency == "some updated currency"
      assert order.entity == "some updated entity"
      assert order.notes == %{}
      assert order.offer_id == "some updated offer_id"
      assert order.receipt == "some updated receipt"
      assert order.status == "some updated status"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_order(order, @invalid_attrs)
      assert order == Transactions.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Transactions.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Transactions.change_order(order)
    end
  end

  describe "transactions" do
    alias Misobo.Transactions.Transaction

    @valid_attrs %{amount: "120.5", receipt: "some receipt", status: "some status"}
    @update_attrs %{
      amount: "456.7",
      receipt: "some updated receipt",
      status: "some updated status"
    }
    @invalid_attrs %{amount: nil, receipt: nil, status: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transactions.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transactions.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transactions.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Transactions.create_transaction(@valid_attrs)
      assert transaction.amount == Decimal.new("120.5")
      assert transaction.receipt == "some receipt"
      assert transaction.status == "some status"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()

      assert {:ok, %Transaction{} = transaction} =
               Transactions.update_transaction(transaction, @update_attrs)

      assert transaction.amount == Decimal.new("456.7")
      assert transaction.receipt == "some updated receipt"
      assert transaction.status == "some updated status"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Transactions.update_transaction(transaction, @invalid_attrs)

      assert transaction == Transactions.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transactions.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transactions.change_transaction(transaction)
    end
  end
end
