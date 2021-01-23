defmodule Misobo.Repo.Migrations.AvailableTime do
  use Ecto.Migration

  def change do
    alter table(:experts) do
      add :available_time, :string
    end
  end
end
