defmodule Misobo.Repo.Migrations.MakePhoneUnique do
  use Ecto.Migration

  def up do
    create unique_index(:users, [:phone])
  end

  def down do
    drop index(:users, [:phone])
  end
end
