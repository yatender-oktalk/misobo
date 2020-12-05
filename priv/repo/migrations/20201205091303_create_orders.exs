defmodule Misobo.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :amount, :integer
      add :amount_due, :integer
      add :amount_paid, :integer
      add :attempts, :integer
      add :created_at, :integer
      add :currency, :string
      add :entity, :string
      add :notes, :map
      add :offer_id, :string
      add :receipt, :string
      add :status, :string

      timestamps()
    end

  end
end
