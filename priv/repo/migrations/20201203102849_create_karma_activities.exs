defmodule Misobo.Repo.Migrations.CreateKarmaActivities do
  use Ecto.Migration

  def change do
    create table(:karma_activities) do
      add :karma_points, :integer
      add :event_type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:karma_activities, [:user_id])
  end
end
