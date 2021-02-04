defmodule Misobo.Repo.Migrations.AddOrderColumns do
  use Ecto.Migration

  def change do
    alter table(:rewards) do
      add :order, :integer
    end
  end
end
