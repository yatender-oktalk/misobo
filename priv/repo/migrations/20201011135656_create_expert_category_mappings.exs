defmodule Misobo.Repo.Migrations.CreateExpertCategoryMappings do
  use Ecto.Migration

  def change do
    create table(:expert_category_mappings, primary_key: false) do
      add :category_id, references(:expert_categories, on_delete: :delete_all), primary_key: true
      add :expert_id, references(:experts, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:expert_category_mappings, [:category_id])
    create index(:expert_category_mappings, [:expert_id])

    create(
      unique_index(:expert_category_mappings, [:category_id, :expert_id], name: :category_id_expert_id_unique_index)
    )
  end
end
