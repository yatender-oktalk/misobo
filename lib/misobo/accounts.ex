defmodule Misobo.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Retruns `nil` if the User does not exist.

  ## Examples

      iex> get_user(123)
      {:ok, %User{}}

      iex> get_user(456)
      {:ok, nil}

  """
  def get_user(id), do: Repo.get(User, id)

  @doc """
  Gets user by params.

  Retruns `nil` if the User does not exist.

  ## Examples

      iex> get_user_by({phone: "8989898989"})
      nil

      iex> get_user_by({phone: "8989898989"})
      %User{}

  """
  def get_user_by(params), do: Repo.get_by(User, params)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  alias Misobo.Accounts.LoginStreak

  @doc """
  Returns the list of login_streaks.

  ## Examples

      iex> list_login_streaks()
      [%LoginStreak{}, ...]

  """
  def list_login_streaks do
    Repo.all(LoginStreak)
  end

  @doc """
  Gets a single login_streak.

  Raises `Ecto.NoResultsError` if the Login streak does not exist.

  ## Examples

      iex> get_login_streak!(123)
      %LoginStreak{}

      iex> get_login_streak!(456)
      ** (Ecto.NoResultsError)

  """
  def get_login_streak!(id), do: Repo.get!(LoginStreak, id)

  @doc """
  Creates a login_streak.

  ## Examples

      iex> create_login_streak(%{field: value})
      {:ok, %LoginStreak{}}

      iex> create_login_streak(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_login_streak(attrs \\ %{}) do
    %LoginStreak{}
    |> LoginStreak.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a login_streak.

  ## Examples

      iex> update_login_streak(login_streak, %{field: new_value})
      {:ok, %LoginStreak{}}

      iex> update_login_streak(login_streak, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_login_streak(%LoginStreak{} = login_streak, attrs) do
    login_streak
    |> LoginStreak.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a login_streak.

  ## Examples

      iex> delete_login_streak(login_streak)
      {:ok, %LoginStreak{}}

      iex> delete_login_streak(login_streak)
      {:error, %Ecto.Changeset{}}

  """
  def delete_login_streak(%LoginStreak{} = login_streak) do
    Repo.delete(login_streak)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking login_streak changes.

  ## Examples

      iex> change_login_streak(login_streak)
      %Ecto.Changeset{data: %LoginStreak{}}

  """
  def change_login_streak(%LoginStreak{} = login_streak, attrs \\ %{}) do
    LoginStreak.changeset(login_streak, attrs)
  end
end
