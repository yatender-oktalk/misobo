defmodule Misobo.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :desc, :string

      timestamps()
    end

  end
end
