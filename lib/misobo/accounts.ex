defmodule Misobo.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false

  alias Misobo.Accounts.User
  alias Misobo.Categories.Category
  alias Misobo.Categories.RegistrationCategory
  alias Misobo.Categories.RegistrationSubCategory
  alias Misobo.Categories.SubCategory
  alias Misobo.Repo
  alias Misobo.Karmas
  alias Misobo.Karmas.KarmaActivity

  alias Misobo.Accounts.Registration
  alias Misobo.TimeUtils
  import Misobo.TimeUtils

  require Logger

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
  def get_user(id),
    do: User |> Repo.get(id) |> Repo.preload(:login_streak) |> handle_login_streak_resp()

  @doc """
  Gets user by params.

  Retruns `nil` if the User does not exist.

  ## Examples

      iex> get_user_by({phone: "8989898989"})
      nil

      iex> get_user_by({phone: "8989898989"})
      %User{}

  """
  def get_user_by(params),
    do: User |> Repo.get_by(params) |> Repo.preload(:login_streak) |> handle_login_streak_resp

  def get_user_profile(id) do
    from(u in User)
    |> where([u], u.id == ^id)
    |> preload(:login_streak)
    |> Repo.one()
    |> handle_login_streak_resp()
  end

  def handle_user_create(nil, params) do
    create_user(params)
  end

  def handle_user_create(%User{} = user, params) do
    update_user(user, params)
  end

  def handle_login_streak_resp(nil), do: nil

  def handle_login_streak_resp(struct) do
    day_of_week = get_day_of_week_today()

    case struct.login_streak do
      nil ->
        struct

      _ ->
        login_streak =
          case day_of_week do
            7 ->
              Map.put(struct.login_streak, :"7", "TODAY")

            _ ->
              Enum.reduce(day_of_week..7, struct.login_streak, fn day, acc ->
                case day == day_of_week do
                  true ->
                    Map.put(acc, :"#{day}", "TODAY")

                  false ->
                    Map.put(acc, :"#{day}", "")
                end
              end)
          end

        login_streak =
          Enum.reduce(1..7, login_streak, fn day, acc ->
            Map.put(acc, :"#{day}", Map.get(login_streak, :"#{day}") |> modify_val())
          end)

        Map.put(struct, :login_streak, login_streak)
    end
  end

  def modify_val(""), do: ""
  def modify_val(true), do: "TRUE"
  def modify_val(false), do: "FALSE"
  def modify_val(data), do: data

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

  def handle_update_phone(attrs, %User{} = user) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
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

  def get_login_streak_by(params), do: Repo.get_by(LoginStreak, params)

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

  def handle_login_streak(%User{id: id} = user) do
    day_of_week = get_day_of_week_today()
    login_streak = id |> checkout_login_streak()
    changeset = login_streak |> LoginStreak.changeset(%{"#{day_of_week}": true})

    # Then increase the streak
    handle_streak(changeset, login_streak, user)
    handle_create_login(id)

    Repo.insert_or_update(changeset)
  end

  def handle_streak(
        changeset,
        _login_streak,
        %User{login_streak_days: login_streak_days, id: id} = user
      ) do
    # Reset if last day didn't login
    end_time = DateTime.utc_now() |> DateTime.add(-84600) |> TimeUtils.end_time_today()
    start_time = DateTime.utc_now() |> DateTime.add(-84600) |> TimeUtils.start_time_today()

    if !get_user_logins(id, start_time, end_time) do
      update_user(user, %{login_streak_days: 1})
    else
      # if logged in then just update 1
      if(changeset.valid? == true and changeset.changes != Map.new()) do
        update_user(user, %{login_streak_days: login_streak_days + 1})
      end
    end
  end

  def handle_create_login(id) do
    end_time_today = TimeUtils.end_time_today(DateTime.utc_now())
    start_time_today = TimeUtils.start_time_today(DateTime.utc_now())
    # create user login
    if !get_user_logins(id, start_time_today, end_time_today) do
      create_user_logins(%{login_date: DateTime.utc_now(), user_id: id})
    end
  end

  def checkout_login_streak(user_id) do
    case result = get_login_streak_by(%{user_id: user_id}) do
      nil ->
        %LoginStreak{user_id: user_id}

      _ ->
        result
    end
  end

  def get_last_day() do
    result =
      case get_day_of_week_today() - 1 do
        0 -> 7
        result -> result
      end

    to_string(result)
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
  def get_registration(nil), do: nil

  def get_registration(id),
    do: Registration |> Repo.get(id) |> Repo.preload([:categories, :sub_categories])

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

  def create_registration_user(attrs) do
    Repo.transaction(fn ->
      with {:ok, %Registration{id: id} = registration} <- create_registration(attrs),
           {:ok, %User{} = user} <- create_user(%{registration_id: id}) do
        {registration, user}
      else
        {:error, changeset} ->
          error =
            Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

          Repo.rollback(error)
          {:error, error}
      end
    end)
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

  def registration_catgories(registration_id) do
    q =
      from u in Category,
        inner_join: rc in RegistrationCategory,
        on: rc.category_id == u.id,
        where: rc.registration_id == ^registration_id,
        select: %{
          name: u.name,
          id: u.id
        }

    categories = Repo.all(q)

    registration_id
    |> get_registration()
    |> Map.put(:categories, categories)
  end

  def registration_sub_catgories(registration_id) do
    q =
      from u in SubCategory,
        inner_join: rc in RegistrationSubCategory,
        on: rc.sub_category_id == u.id,
        where: rc.registration_id == ^registration_id,
        select: %{
          name: u.name,
          id: u.id
        }

    sub_categories = Repo.all(q)

    registration_id
    |> get_registration()
    |> Map.put(:sub_categories, sub_categories)
  end

  def registration_categories_preloaded(registration_id) do
    registration_id
    |> get_registration()
    |> Repo.preload(:categories)
  end

  def registration_sub_categories_preloaded(registration_id) do
    registration_id
    |> get_registration()
    |> Repo.preload(:sub_categories)
  end

  def upsert_registration_categories(registration, categories)
      when is_list(categories) do
    categories = Misobo.Categories.get_categories(categories)

    resp =
      registration
      |> Registration.changeset_update_registration_categories(categories)
      |> Repo.update()

    case resp do
      {:ok, _struct} ->
        {:ok, get_registration(registration.id)}

      error ->
        {:error, error}
    end
  end

  def upsert_registration_sub_categories(registration, sub_categories)
      when is_list(sub_categories) do
    sub_categories = Misobo.Categories.get_sub_categories(sub_categories)

    resp =
      registration
      |> Registration.changeset_update_registration_sub_categories(sub_categories)
      |> Repo.update()

    case resp do
      {:ok, _struct} ->
        {:ok, get_registration(registration.id)}

      error ->
        {:error, error}
    end
  end

  def existing_registration?(%Registration{id: id}) do
    get_user_by(registration_id: id) == nil
  end

  def calculate_bmi(height, weight) do
    bmi = weight / (height * height)
    {:ok, %{"bmi" => Float.ceil(bmi, 2), "result" => bmi_result(bmi)}}
  end

  def add_karma(user_id, karma_points, event_type, music_id \\ nil) do
    case Karmas.get_karma_activity_by(%{event_type: event_type, user_id: user_id}) do
      nil ->
        Repo.transaction(fn ->
          with {:ok, %KarmaActivity{}} <-
                 Karmas.create_karma_activity(%{
                   user_id: user_id,
                   karma_points: karma_points,
                   event_type: event_type,
                   music_id: music_id
                 }),
               %User{karma_points: existing_karma_points} = user <- get_user_locked(user_id),
               {:ok, %User{} = user} <-
                 update_user(user, %{karma_points: existing_karma_points + karma_points}) do
            user
          else
            {:error, changeset} ->
              error =
                Ecto.Changeset.traverse_errors(
                  changeset,
                  &MisoboWeb.ErrorHelpers.translate_error/1
                )

              Repo.rollback(error)
              {:error, error}
          end
        end)

      _ ->
        {:ok, Misobo.Accounts.get_user(user_id)}
    end
  end

  def deduct_karma(user_id, karma_points, event_type) do
    Repo.transaction(fn ->
      with {:ok, %KarmaActivity{}} <-
             Karmas.create_karma_activity(%{
               user_id: user_id,
               karma_points: -1 * karma_points,
               event_type: event_type
             }),
           %User{karma_points: existing_karma_points} = user <- get_user_locked(user_id),
           {:ok, %User{} = user} <-
             update_user(user, %{karma_points: existing_karma_points - karma_points}) do
        user
      else
        {:error, changeset} ->
          error =
            Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

          Repo.rollback(error)
          {:error, error}
      end
    end)
  end

  def get_user_locked(id) do
    Repo.one(from a in User, where: a.id == ^id, lock: "FOR UPDATE")
  end

  defp bmi_result(bmi) do
    cond do
      bmi <= 18.5 ->
        "underweight"

      18.5 < bmi && bmi <= 24.9 ->
        "normal"

      24.9 < bmi && bmi <= 29.9 ->
        "overweight"

      bmi > 29.9 ->
        "obese"

      true ->
        "Nothing"
    end
  end

  def clear_login_streak() do
    Logger.info("cleared Loggin streak")
    Repo.delete_all(LoginStreak)
  end

  alias Misobo.Accounts.UserLogins

  @doc """
  Returns the list of user_logins.

  ## Examples

      iex> list_user_logins()
      [%UserLogins{}, ...]

  """
  def list_user_logins do
    Repo.all(UserLogins)
  end

  @doc """
  Gets a single user_logins.

  Raises `Ecto.NoResultsError` if the User logins does not exist.

  ## Examples

      iex> get_user_logins!(123)
      %UserLogins{}

      iex> get_user_logins!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_logins!(id), do: Repo.get!(UserLogins, id)

  def get_user_logins(id, start_time, end_time) do
    query =
      from u in UserLogins,
        where:
          u.login_date >= ^start_time and
            u.login_date <= ^end_time and
            u.user_id == ^id

    Repo.exists?(query)
  end

  @doc """
  Creates a user_logins.

  ## Examples

      iex> create_user_logins(%{field: value})
      {:ok, %UserLogins{}}

      iex> create_user_logins(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_logins(attrs \\ %{}) do
    %UserLogins{}
    |> UserLogins.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_logins.

  ## Examples

      iex> update_user_logins(user_logins, %{field: new_value})
      {:ok, %UserLogins{}}

      iex> update_user_logins(user_logins, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_logins(%UserLogins{} = user_logins, attrs) do
    user_logins
    |> UserLogins.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_logins.

  ## Examples

      iex> delete_user_logins(user_logins)
      {:ok, %UserLogins{}}

      iex> delete_user_logins(user_logins)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_logins(%UserLogins{} = user_logins) do
    Repo.delete(user_logins)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_logins changes.

  ## Examples

      iex> change_user_logins(user_logins)
      %Ecto.Changeset{data: %UserLogins{}}

  """
  def change_user_logins(%UserLogins{} = user_logins, attrs \\ %{}) do
    UserLogins.changeset(user_logins, attrs)
  end
end
