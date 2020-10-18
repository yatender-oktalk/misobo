defmodule Misobo.Repo.Migrations.CreateRegistrationSubCategories do
  use Ecto.Migration

  def change do
    create table(:registration_sub_categories) do
      add :registration_id, references(:registrations, on_delete: :nothing)
      add :sub_category_id, references(:sub_categories, on_delete: :nothing)

      timestamps()
    end

    create index(:registration_sub_categories, [:registration_id])
    create index(:registration_sub_categories, [:sub_category_id])

    create(
      unique_index(:registration_sub_categories, [:registration_id, :sub_category_id],
        name: :sub_category_id_registration_id_unique_index
      )
    )
  end
end
