defmodule Misobo.Musics do
  @moduledoc """
  The Musics context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Musics.Music

  @doc """
  Returns the list of musics.

  ## Examples

      iex> list_musics()
      [%Music{}, ...]

  """
  def list_musics do
    Repo.all(Music)
  end

  def list_musics_paginated(page, is_mind_pack_unlocked, is_body_pack_unlocked) do
    query = get_music_list_query(is_mind_pack_unlocked, is_body_pack_unlocked)

    query
    |> Repo.paginate(page: page)
  end

  def get_music_list_query(true, false) do
    from u in Music, where: u.tag == ^"MIND"
  end

  def get_music_list_query(false, true) do
    from u in Music, where: u.tag == ^"BODY"
  end

  def get_music_list_query(_is_mind_pack_unlocked, _is_body_pack_unlocked) do
    Music
  end

  @doc """
  Gets a single music.

  Raises `Ecto.NoResultsError` if the Music does not exist.

  ## Examples

      iex> get_music!(123)
      %Music{}

      iex> get_music!(456)
      ** (Ecto.NoResultsError)

  """
  def get_music!(id), do: Repo.get!(Music, id)

  def get_music(id), do: Repo.get(Music, id)

  @doc """
  Creates a music.

  ## Examples

      iex> create_music(%{field: value})
      {:ok, %Music{}}

      iex> create_music(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_music(attrs \\ %{}) do
    %Music{}
    |> Music.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a music.

  ## Examples

      iex> update_music(music, %{field: new_value})
      {:ok, %Music{}}

      iex> update_music(music, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_music(%Music{} = music, attrs) do
    music
    |> Music.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a music.

  ## Examples

      iex> delete_music(music)
      {:ok, %Music{}}

      iex> delete_music(music)
      {:error, %Ecto.Changeset{}}

  """
  def delete_music(%Music{} = music) do
    Repo.delete(music)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking music changes.

  ## Examples

      iex> change_music(music)
      %Ecto.Changeset{data: %Music{}}

  """
  def change_music(%Music{} = music, attrs \\ %{}) do
    Music.changeset(music, attrs)
  end

  alias Misobo.Musics.UserMusicProgress

  @doc """
  Returns the list of user_music_progress.

  ## Examples

      iex> list_user_music_progress()
      [%UserMusicProgress{}, ...]

  """
  def list_user_music_progress do
    Repo.all(UserMusicProgress)
  end

  @doc """
  Gets a single user_music_progress.

  Raises `Ecto.NoResultsError` if the User music progress does not exist.

  ## Examples

      iex> get_user_music_progress!(123)
      %UserMusicProgress{}

      iex> get_user_music_progress!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_music_progress!(id), do: Repo.get!(UserMusicProgress, id)

  def get_user_music_progress_by(params), do: Repo.get_by(UserMusicProgress, params)

  @doc """
  Creates a user_music_progress.

  ## Examples

      iex> create_user_music_progress(%{field: value})
      {:ok, %UserMusicProgress{}}

      iex> create_user_music_progress(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_music_progress(attrs \\ %{}) do
    %UserMusicProgress{}
    |> UserMusicProgress.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_music_progress.

  ## Examples

      iex> update_user_music_progress(user_music_progress, %{field: new_value})
      {:ok, %UserMusicProgress{}}

      iex> update_user_music_progress(user_music_progress, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_music_progress(%UserMusicProgress{} = user_music_progress, attrs) do
    user_music_progress
    |> UserMusicProgress.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_music_progress.

  ## Examples

      iex> delete_user_music_progress(user_music_progress)
      {:ok, %UserMusicProgress{}}

      iex> delete_user_music_progress(user_music_progress)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_music_progress(%UserMusicProgress{} = user_music_progress) do
    Repo.delete(user_music_progress)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_music_progress changes.

  ## Examples

      iex> change_user_music_progress(user_music_progress)
      %Ecto.Changeset{data: %UserMusicProgress{}}

  """
  def change_user_music_progress(%UserMusicProgress{} = user_music_progress, attrs \\ %{}) do
    UserMusicProgress.changeset(user_music_progress, attrs)
  end

  def track_user_music_progress(id, user_id, progress) do
    data =
      case get_user_music_progress_by(%{music_id: id, user_id: user_id}) do
        # Entry not found, we build one
        nil -> %UserMusicProgress{}
        # Entry exists, let's use it
        post -> post
      end

    result =
      data
      |> UserMusicProgress.changeset(%{music_id: id, user_id: user_id, progress: progress})
      |> Repo.insert_or_update()

    case result do
      {:ok, struct} ->
        {:ok, struct}

      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def add_user_musics_progress(%{entries: entries} = _data, user_id) do
    user_musics = get_user_musics(user_id)

    entries
    |> Enum.map(fn entry ->
      entry
      |> Map.from_struct()
      |> Map.delete(:__meta__)
      |> Map.put(:progress, Map.get(user_musics, entry.id, 0))
    end)
  end

  # Private functions

  defp get_user_musics(user_id) do
    base_user_music_progress()
    |> filter_by_user_id(user_id)
    |> filter_select()
    |> Repo.all()
    |> mapify()
  end

  defp base_user_music_progress, do: from(u in UserMusicProgress)
  defp filter_by_user_id(q, user_id), do: q |> where([u], u.user_id == ^user_id)
  defp filter_select(q), do: q |> select([u], {u.music_id, u.progress})

  # Mapify
  defp mapify([]), do: %{}

  defp mapify(music_progress_list) do
    Enum.reduce(music_progress_list, %{}, fn {music_id, progress}, acc ->
      Map.put(acc, music_id, progress)
    end)
  end
end
