defmodule Misobo.Repo.Migrations.AddImageToMusic do
  use Ecto.Migration

  def change do
    alter table(:musics) do
      add :image, :string
    end
  end
end
