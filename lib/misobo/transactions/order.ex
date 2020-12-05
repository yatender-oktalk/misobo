defmodule Misobo.Transactions.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :amount, :integer
    field :amount_due, :integer
    field :amount_paid, :integer
    field :attempts, :integer
    field :created_at, :integer
    field :currency, :string
    field :entity, :string
    field :notes, :map
    field :offer_id, :string
    field :receipt, :string
    field :status, :string
    field :pg_order_id, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [
      :amount,
      :amount_due,
      :amount_paid,
      :attempts,
      :created_at,
      :currency,
      :entity,
      :notes,
      :offer_id,
      :receipt,
      :status,
      :pg_order_id
    ])
    |> validate_required([
      :amount,
      :amount_due,
      :amount_paid,
      :created_at,
      :currency,
      :entity,
      :receipt,
      :status,
      :pg_order_id
    ])
  end
end
