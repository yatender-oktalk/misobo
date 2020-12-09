defmodule Misobo.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :rating, :integer
      add :booking_id, references(:bookings, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :expert_id, references(:experts, on_delete: :nothing)

      timestamps()
    end

    create index(:ratings, [:booking_id])
    create index(:ratings, [:user_id])
    create index(:ratings, [:expert_id])
  end
end
