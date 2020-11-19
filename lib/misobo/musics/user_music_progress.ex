defmodule Misobo.Musics.UserMusicProgress do
  @moduledoc """
  This module contains the data relatted to user music progress
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Accounts.User
  alias Misobo.Musics.Music

  @required [:user_id, :music_id, :progress]
  @optional []

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :progress,
               :user_id,
               :music_id,
               :inserted_at,
               :updated_at
             ]
           ]}
  schema "user_music_progress" do
    field :progress, :integer

    belongs_to :user, User
    belongs_to :music, Music

    timestamps()
  end

  @doc false
  def changeset(user_music_progress, attrs) do
    user_music_progress
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
