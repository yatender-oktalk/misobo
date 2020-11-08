defmodule Misobo.Repo.Migrations.CreateUserMusicProgress do
  use Ecto.Migration

  def change do
    create table(:user_music_progress) do
      add :progress, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :music_id, references(:musics, on_delete: :nothing)

      timestamps()
    end

    create index(:user_music_progress, [:user_id])
    create index(:user_music_progress, [:music_id])
  end
end
