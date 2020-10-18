defmodule Misobo.Repo.Migrations.CreateRegistrationCategories do
  use Ecto.Migration

  def change do
    create table(:registration_categories) do
      add :registration_id, references(:registrations, on_delete: :nothing)
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:registration_categories, [:registration_id])
    create index(:registration_categories, [:category_id])
  end
end
