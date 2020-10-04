defmodule Misobo.Repo.Migrations.CreateSubCategories do
  use Ecto.Migration

  def change do
    create table(:sub_categories) do
      add :name, :string
      add :desc, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:sub_categories, [:category_id])
  end
end
