defmodule Misobo.Repo.Migrations.CreateUserLogins do
  use Ecto.Migration

  def change do
    create table(:user_logins) do
      add :login_date, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_logins, [:user_id])
  end
end
