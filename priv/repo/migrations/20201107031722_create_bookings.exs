defmodule Misobo.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :start_time_unix, :integer
      add :end_time_unix, :integer
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :karma, :integer
      add :expert_id, references(:experts, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:bookings, [:expert_id])
    create index(:bookings, [:user_id])
  end
end
