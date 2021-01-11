defmodule Misobo.Repo.Migrations.AddFieldsIntoExperts do
  use Ecto.Migration

  def change do
    alter table(:experts) do
      add :qualification, :string
      add :expertise, :string
      add :location, :string
      add :tags, :string
      add :email, :string
    end
  end
end
