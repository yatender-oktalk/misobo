defmodule Misobo.Repo.Migrations.AddDailyReminder do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :daily_reminder, :integer
    end
  end
end
