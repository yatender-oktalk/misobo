defmodule Misobo.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Accounts.User
  alias Misobo.Repo
  import Misobo.TimeUtils

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

  def get_login_streak(id), do: Repo.get(LoginStreak, id)

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

  def handle_login_streak(%User{id: id} = _user) do
    day_of_week = get_day_of_week_today()

    id
    |> checkout_login_streak()
    |> LoginStreak.changeset(%{"#{day_of_week}": true})
    |> Repo.insert_or_update()
  end

  defp checkout_login_streak(user_id) do
    case result = get_login_streak(user_id) do
      nil ->
        %LoginStreak{user_id: user_id}

      _ ->
        result
    end
  end

  alias Misobo.Accounts.Registration

  @doc """
  Returns the list of registrations.

  ## Examples

      iex> list_registrations()
      [%Registration{}, ...]

  """
  def list_registrations do
    Repo.all(Registration)
  end

  @doc """
  Gets a single registration.

  Raises `Ecto.NoResultsError` if the Registration does not exist.

  ## Examples

      iex> get_registration!(123)
      %Registration{}

      iex> get_registration!(456)
      ** (Ecto.NoResultsError)

  """
  def get_registration!(id), do: Repo.get!(Registration, id)

  @doc """
  Gets a single registration.

  ## Examples

      iex> get_registration(123)
      {:ok, %Registration{}}

      iex> get_registration(456)
      nil

  """
  def get_registration(id), do: Repo.get(Registration, id)

  @doc """
  Creates a registration.

  ## Examples

      iex> create_registration(%{field: value})
      {:ok, %Registration{}}

      iex> create_registration(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_registration(attrs \\ %{}) do
    %Registration{}
    |> Registration.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a registration.

  ## Examples

      iex> update_registration(registration, %{field: new_value})
      {:ok, %Registration{}}

      iex> update_registration(registration, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_registration(%Registration{} = registration, attrs) do
    registration
    |> Registration.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a registration.

  ## Examples

      iex> delete_registration(registration)
      {:ok, %Registration{}}

      iex> delete_registration(registration)
      {:error, %Ecto.Changeset{}}

  """
  def delete_registration(%Registration{} = registration) do
    Repo.delete(registration)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking registration changes.

  ## Examples

      iex> change_registration(registration)
      %Ecto.Changeset{data: %Registration{}}

  """
  def change_registration(%Registration{} = registration, attrs \\ %{}) do
    Registration.changeset(registration, attrs)
  end
end
