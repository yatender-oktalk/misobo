defmodule Misobo.Repo.Migrations.AddBmiCheckedAt do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :bmi_checked_at, :naive_datetime
    end
  end
end
