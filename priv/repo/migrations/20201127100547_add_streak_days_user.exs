defmodule Misobo.Repo.Migrations.AddStreakDaysUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :login_streak_days, :integer, default: 0
    end
  end
end
