defmodule Misobo.Repo.Migrations.CreatePacks do
  use Ecto.Migration

  def change do
    create table(:packs) do
      add :amount, :decimal
      add :is_enabled, :boolean, default: true, null: false
      add :karma_coins, :integer
      add :tag, :string

      timestamps()
    end
  end
end
