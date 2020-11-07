defmodule Misobo.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add :title, :string
      add :url, :string
      add :hls_url, :string
      add :duration, :integer
      add :karma, :integer
      add :production_name, :string
      add :author_name, :string

      timestamps()
    end

  end
end
