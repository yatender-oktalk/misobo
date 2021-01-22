defmodule Misobo.Repo.Migrations.UnavailableDaysExpert do
  use Ecto.Migration

  def change do
    alter table(:experts) do
      add :unavailable_days, :string
    end
  end
end
