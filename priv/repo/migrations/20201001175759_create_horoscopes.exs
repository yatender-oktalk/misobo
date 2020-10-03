defmodule Misobo.Repo.Migrations.CreateHoroscopes do
  use Ecto.Migration

  def change do
    create table(:horoscopes) do
      add :name, :string

      timestamps()
    end
  end
end
