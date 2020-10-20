defmodule Misobo.Repo.Migrations.AddRegistrationInUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :registration_id, references(:registrations, on_delete: :nothing)
    end
  end
end
