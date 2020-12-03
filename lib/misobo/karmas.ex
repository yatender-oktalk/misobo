defmodule Misobo.Karmas do
  @moduledoc """
  The Karmas context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

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
end
