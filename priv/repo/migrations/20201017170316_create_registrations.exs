defmodule Misobo.Repo.Migrations.CreateRegistrations do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :device_id, :string

      timestamps()
    end

  end
end
