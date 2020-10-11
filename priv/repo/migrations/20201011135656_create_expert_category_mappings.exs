defmodule Misobo.Repo.Migrations.CreateExpertCategoryMappings do
  use Ecto.Migration

  def change do
    create table(:expert_category_mappings) do
      add :category_id, references(:expert_categories, on_delete: :delete_all)
      add :expert_id, references(:experts, on_delete: :delete_all)

      timestamps()
    end

    create index(:expert_category_mappings, [:category_id])
    create index(:expert_category_mappings, [:expert_id])
  end
end
