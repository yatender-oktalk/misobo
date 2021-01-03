defmodule Misobo.Repo.Migrations.AddEmailGenderProfile do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :email, :string
      add :gender, :string
    end
  end
end
