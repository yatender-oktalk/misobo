defmodule Misobo.Transactions.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :decimal
    field :receipt, :string
    field :status, :string
    field :order_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :status, :receipt, :user_id, :order_id])
    |> validate_required([:amount, :status, :receipt, :user_id])
  end
end
