defmodule Misobo.Karmas do
  @moduledoc """
  The Karmas context.
  """

  @music_listen_complete Application.get_env(:misobo, Misobo.Env)[:music_listen_activity]

  require Logger
  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Musics
  alias Misobo.Musics.Music
  alias Misobo.Karmas.KarmaActivity

  @doc """
  Returns the list of karma_activities.

  ## Examples

      iex> list_karma_activities()
      [%KarmaActivity{}, ...]

  """
  def list_karma_activities do
    Repo.all(KarmaActivity)
  end

  @doc """
  Gets a single karma_activity.

  Raises `Ecto.NoResultsError` if the Karma activity does not exist.

  ## Examples

      iex> get_karma_activity!(123)
      %KarmaActivity{}

      iex> get_karma_activity!(456)
      ** (Ecto.NoResultsError)

  """
  def get_karma_activity!(id), do: Repo.get!(KarmaActivity, id)

  # get karma acitivity by params

  def get_karma_activity_by(params), do: Repo.get_by(KarmaActivity, params)

  @doc """
  Creates a karma_activity.

  ## Examples

      iex> create_karma_activity(%{field: value})
      {:ok, %KarmaActivity{}}

      iex> create_karma_activity(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_karma_activity(attrs \\ %{}) do
    %KarmaActivity{}
    |> KarmaActivity.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a karma_activity.

  ## Examples

      iex> update_karma_activity(karma_activity, %{field: new_value})
      {:ok, %KarmaActivity{}}

      iex> update_karma_activity(karma_activity, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_karma_activity(%KarmaActivity{} = karma_activity, attrs) do
    karma_activity
    |> KarmaActivity.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a karma_activity.

  ## Examples

      iex> delete_karma_activity(karma_activity)
      {:ok, %KarmaActivity{}}

      iex> delete_karma_activity(karma_activity)
      {:error, %Ecto.Changeset{}}

  """
  def delete_karma_activity(%KarmaActivity{} = karma_activity) do
    Repo.delete(karma_activity)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking karma_activity changes.

  ## Examples

      iex> change_karma_activity(karma_activity)
      %Ecto.Changeset{data: %KarmaActivity{}}

  """
  def change_karma_activity(%KarmaActivity{} = karma_activity, attrs \\ %{}) do
    KarmaActivity.changeset(karma_activity, attrs)
  end

  def get_karma_changeset(attrs) do
    KarmaActivity.changeset(%KarmaActivity{}, attrs)
  end

  def handle_karma_points(user_id, music_id, progress) do
    Logger.info(
      "Handling Karma points for user_id #{user_id} for music_id #{music_id} for progress #{
        progress
      }"
    )

    music = Musics.get_music(music_id)

    user_id
    |> get_karma_music_activity(music_id)
    |> handle_music_karma_activity(music, user_id: user_id, progress: progress)
  end

  # Add the karma points to user if points not given
  def handle_music_karma_activity(nil, %Music{id: id, karma: karma, duration: duration},
        user_id: user_id,
        progress: progress
      ) do
    Logger.info(
      "Karma points Adding for user_id #{user_id} for music_id #{id} progress #{progress}"
    )

    if get_duration_progress_percentage(duration, progress) >= 95 do
      Misobo.Accounts.add_karma(user_id, karma, @music_listen_complete, id)
      {:karma_points, true}
    else
      Logger.info(
        "Karma points for user_id #{user_id} for #{id} not added as progress is less than 95%"
      )

      {:karma_points, false}
    end
  end

  def handle_music_karma_activity(
        %KarmaActivity{user_id: user_id, music_id: music_id} = _activity,
        _music,
        _data_list
      ) do
    Logger.info("Karma points for user_id #{user_id} for #{music_id} already added to user")
    {:karma_points, false}
  end

  def get_karma_music_activity(user_id, music_id) do
    get_karma_activity_by(%{
      user_id: user_id,
      music_id: music_id,
      event_type: @music_listen_complete
    })
  end

  def get_duration_progress_percentage(duration, progress) do
    floor(100 * progress / duration)
  end
end
