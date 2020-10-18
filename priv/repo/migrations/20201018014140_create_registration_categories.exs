defmodule Misobo.Repo.Migrations.CreateRegistrationCategories do
  use Ecto.Migration

  def change do
    create table(:registration_categories, primary_key: false) do
      add :registration_id, references(:registrations, on_delete: :nothing), primary_key: true
      add :category_id, references(:categories, on_delete: :nothing), primary_key: true

      timestamps()
    end

    create index(:registration_categories, [:registration_id])
    create index(:registration_categories, [:category_id])

    create(
      unique_index(:registration_categories, [:registration_id, :category_id],
        name: :category_id_registration_id_unique_index
      ))
  end
end
