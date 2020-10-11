defmodule Misobo.Repo.Migrations.CreateExpertCategories do
  use Ecto.Migration

  def change do
    create table(:expert_categories) do
      add :name, :string
      add :is_enabled, :boolean, default: false, null: false
      add :enabled_at, :naive_datetime

      timestamps()
    end

  end
end
