defmodule Misobo.Musics.Music do
  use Ecto.Schema
  import Ecto.Changeset

  schema "musics" do
    field :author_name, :string
    field :duration, :integer
    field :hls_url, :string
    field :karma, :integer
    field :production_name, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(music, attrs) do
    music
    |> cast(attrs, [:title, :url, :hls_url, :duration, :karma, :production_name, :author_name])
    |> validate_required([:title, :url, :hls_url, :duration, :karma, :production_name, :author_name])
  end
end
