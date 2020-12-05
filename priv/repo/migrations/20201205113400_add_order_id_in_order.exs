defmodule Misobo.Repo.Migrations.AddOrderIdInOrder do
  use Ecto.Migration

  def change do
    alter table(:orders) do
      add :pg_order_id, :string
    end
  end
end
