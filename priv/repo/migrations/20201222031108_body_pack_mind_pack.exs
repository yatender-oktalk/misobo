defmodule Misobo.Repo.Migrations.BodyPackMindPack do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_body_pack_unlocked, :boolean, default: false
      add :is_mind_pack_unlocked, :boolean, default: false
    end
  end
end
