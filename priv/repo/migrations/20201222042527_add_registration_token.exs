defmodule Misobo.Repo.Migrations.AddRegistrationToken do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :fcm_registration_token, :string
    end
  end
end
