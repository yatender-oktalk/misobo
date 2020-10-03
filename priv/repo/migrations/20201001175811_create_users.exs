defmodule Misobo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :phone, :string
      add :is_enabled, :boolean, default: false, null: false
      add :otp, :integer
      add :karma_points, :integer
      add :dob, :naive_datetime
      add :otp_valid_time, :naive_datetime
      add :horoscope_id, references(:horoscopes, on_delete: :nothing)

      timestamps()
    end

    create index(:users, [:horoscope_id])
    create unique_index(:users, [:phone])
  end
end
