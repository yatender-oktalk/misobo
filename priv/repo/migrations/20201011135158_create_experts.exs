defmodule Misobo.Repo.Migrations.CreateExperts do
  use Ecto.Migration

  def change do
    create table(:experts) do
      add :name, :string
      add :language, :string
      add :rating, :decimal
      add :total_consultations, :integer
      add :experience, :integer
      add :img, :string
      add :consult_karma, :integer
      add :about, :text
      add :is_enabled, :boolean, default: false, null: false
      add :category_order, :integer
      add :order, :integer

      timestamps()
    end
  end
end
