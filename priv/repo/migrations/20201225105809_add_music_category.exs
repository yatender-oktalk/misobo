defmodule Misobo.Repo.Migrations.AddMusicCategory do
  use Ecto.Migration

  def change do
    alter table(:musics) do
      add :tag, :string
    end
  end
end
