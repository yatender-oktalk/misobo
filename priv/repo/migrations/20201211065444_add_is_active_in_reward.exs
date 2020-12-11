defmodule Misobo.Repo.Migrations.AddIsActiveInReward do
  use Ecto.Migration

  def change do
    alter table(:rewards) do
      add :is_active, :boolean, default: true
    end
  end
end
