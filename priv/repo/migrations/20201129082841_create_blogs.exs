defmodule Misobo.Repo.Migrations.CreateBlogs do
  use Ecto.Migration

  def change do
    create table(:blogs) do
      add :title, :string
      add :content, :text
      add :image, :string
      add :is_enabled, :boolean, default: true, null: false
      add :category, :string

      timestamps()
    end

  end
end
