defmodule Misobo.Repo.Migrations.DropPhoneIndexUser do
  use Ecto.Migration

  def change do
    drop unique_index(:users, [:phone])
  end
end
