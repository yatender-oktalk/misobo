defmodule Misobo.Musics.UserMusicProgress do
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Musics.Music
  alias Misobo.Accounts.User

  @required [:user_id, :music_id, :progress]
  @optional []

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
