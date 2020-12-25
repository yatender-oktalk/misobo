defmodule Misobo.Repo.Migrations.AddResultBmiInProfile do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :result, :string
    end
  end
end
