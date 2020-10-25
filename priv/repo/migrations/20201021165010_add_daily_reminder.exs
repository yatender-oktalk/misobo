defmodule Misobo.Repo.Migrations.AddDailyReminder do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :daily_reminder, :integer
      add :img, :string
      add :weight, :float
      add :bmi, :float
      add :height, :float
    end
  end
end
