defmodule Misobo.Repo.Migrations.IndexForDailyReminder do
  use Ecto.Migration

  def up do
    create index(:users, [:daily_reminder])
  end

  def down do
    drop index(:users, [:daily_reminder])
  end
end
