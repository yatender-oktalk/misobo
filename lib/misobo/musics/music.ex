defmodule Misobo.Musics.Music do
  @moduledoc """
  This module contains the data relatted to music context
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required [:title, :url, :hls_url, :duration, :karma]
  @optional [:production_name, :author_name]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :author_name,
               :duration,
               :hls_url,
               :karma,
               :production_name,
               :title,
               :url
             ]
           ]}
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
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
