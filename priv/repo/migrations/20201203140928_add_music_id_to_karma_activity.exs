defmodule Misobo.Repo.Migrations.AddMusicIdToKarmaActivity do
  use Ecto.Migration

  def change do
    alter table(:karma_activities) do
      add :music_id, references(:musics, on_delete: :nothing)
    end
  end
end
