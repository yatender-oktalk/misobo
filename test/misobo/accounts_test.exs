defmodule Misobo.AccountsTest do
  use Misobo.DataCase

  alias Misobo.Accounts
  alias Misobo.Accounts.LoginStreak

  describe "users" do
    alias Misobo.Accounts.User

    @valid_attrs %{
      dob: ~N[2010-04-17 14:00:00],
      otp_valid_time: ~N[2010-04-17 14:30:00],
      is_enabled: true,
      karma_points: 42,
      name: "some name",
      otp: 42,
      phone: "90909090"
    }
    @update_attrs %{
      dob: ~N[2011-05-18 15:01:01],
      is_enabled: false,
      karma_points: 43,
      name: "some updated name",
      otp: 43,
      phone: "some updated phone"
    }
    @invalid_attrs %{
      dob: nil,
      is_enabled: "random",
      karma_points: nil,
      name: nil,
      otp: nil,
      phone: nil
    }

    def user_fixture(attrs \\ %{}) do
      registration = registration_fixture_d()

      {:ok, user} =
        attrs
        |> Map.merge(%{registration_id: registration.id})
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      registration = registration_fixture_d()

      assert {:ok, %User{} = user} =
               Accounts.create_user(Map.merge(@valid_attrs, %{registration_id: registration.id}))

      assert user.dob == ~N[2010-04-17 14:00:00]
      assert user.is_enabled == true
      assert user.karma_points == 42
      assert user.name == "some name"
      assert user.otp == 42
      assert user.phone == "90909090"
      assert user.registration_id == registration.id
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.dob == ~N[2011-05-18 15:01:01]
      assert user.is_enabled == false
      assert user.karma_points == 43
      assert user.name == "some updated name"
      assert user.otp == 43
      assert user.phone == "some updated phone"
    end

    @tag :wip
    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert nil == Accounts.get_user(user.id)
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "login_streaks" do
    alias Misobo.Accounts.LoginStreak

    @valid_attrs %{
      "1": true,
      "2": true,
      "3": true,
      "4": true,
      "5": true,
      "6": true,
      "7": true,
      streak_days: 42
    }
    @update_attrs %{
      "1": false,
      "2": false,
      "3": false,
      "4": false,
      "5": false,
      "6": false,
      "7": false,
      streak_days: 43
    }
    @invalid_attrs %{
      "1": nil,
      "2": nil,
      "3": nil,
      "4": nil,
      "5": nil,
      "6": nil,
      "7": nil,
      streak_days: nil
    }

    def login_streak_fixture(attrs \\ %{}) do
      {:ok, login_streak} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_login_streak()

      login_streak
    end

    def user_fixture_for_login(attrs \\ %{}) do
      registration = registration_fixture_d()

      attrs =
        Map.merge(
          %{
            dob: ~N[2010-04-17 14:00:00],
            otp_valid_time: ~N[2010-04-17 14:30:00],
            is_enabled: true,
            karma_points: 42,
            name: "some name",
            otp: 42,
            phone: "90909090",
            registration_id: registration.id
          },
          attrs
        )

      {:ok, user} = attrs |> Accounts.create_user()

      user
    end

    def registration_fixture_d(attrs \\ %{}) do
      attrs =
        Map.merge(
          %{
            device_id: Ecto.UUID.generate()
          },
          attrs
        )

      {:ok, registration} = attrs |> Accounts.create_registration()
      registration
    end

    test "list_login_streaks/0 returns all login_streaks" do
      user = user_fixture_for_login(%{phone: "9090909091"})
      login_streak = login_streak_fixture(%{user_id: user.id})
      assert Accounts.list_login_streaks() == [login_streak]
    end

    test "get_login_streak!/1 returns the login_streak with given id" do
      user = user_fixture_for_login(%{phone: "9090909092"})
      login_streak = login_streak_fixture(%{user_id: user.id})
      assert Accounts.get_login_streak!(login_streak.id) == login_streak
    end

    test "create_login_streak/1 with valid data creates a login_streak" do
      user = user_fixture_for_login(%{phone: "9090909097"})

      assert {:ok, %LoginStreak{} = login_streak} =
               Accounts.create_login_streak(Map.merge(@valid_attrs, %{user_id: user.id}))

      assert login_streak."1" == true
      assert login_streak."2" == true
      assert login_streak."3" == true
      assert login_streak."4" == true
      assert login_streak."5" == true
      assert login_streak."6" == true
      assert login_streak."7" == true
      assert login_streak.streak_days == 42
    end

    test "create_login_streak/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_login_streak(@invalid_attrs)
    end

    test "update_login_streak/2 with valid data updates the login_streak" do
      user = user_fixture_for_login(%{phone: "9090909096"})
      login_streak = login_streak_fixture(%{user_id: user.id})

      assert {:ok, %LoginStreak{} = login_streak} =
               Accounts.update_login_streak(login_streak, @update_attrs)

      assert login_streak."1" == false
      assert login_streak."2" == false
      assert login_streak."3" == false
      assert login_streak."4" == false
      assert login_streak."5" == false
      assert login_streak."6" == false
      assert login_streak."7" == false
      assert login_streak.streak_days == 43
    end

    test "update_login_streak/2 with invalid data returns error changeset" do
      user = user_fixture_for_login(%{phone: "9090909092"})
      login_streak = login_streak_fixture(%{user_id: user.id})

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_login_streak(login_streak, @invalid_attrs)

      assert login_streak == Accounts.get_login_streak!(login_streak.id)
    end

    test "delete_login_streak/1 deletes the login_streak" do
      user = user_fixture_for_login(%{phone: "9090909095"})
      login_streak = login_streak_fixture(%{user_id: user.id})
      assert {:ok, %LoginStreak{}} = Accounts.delete_login_streak(login_streak)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_login_streak!(login_streak.id) end
    end

    test "change_login_streak/1 returns a login_streak changeset" do
      user = user_fixture_for_login(%{phone: "9090909094"})
      login_streak = login_streak_fixture(%{user_id: user.id})
      assert %Ecto.Changeset{} = Accounts.change_login_streak(login_streak)
    end

    test "login streak check" do
      # setup
      user = user_fixture_for_login(%{phone: "9090909096"})
      login_streak_default = login_streak_fixture(Map.merge(@update_attrs, %{user_id: user.id}))
      day_of_week = Misobo.TimeUtils.get_day_of_week_today()

      assert false == get_term_from_day(login_streak_default, day_of_week)
      {:ok, streak} = Accounts.handle_login_streak(user)
      assert true == get_term_from_day(streak, day_of_week)
    end

    defp get_term_from_day(streak, day) do
      case day do
        1 -> streak."1"
        2 -> streak."2"
        3 -> streak."3"
        4 -> streak."4"
        5 -> streak."5"
        6 -> streak."6"
        7 -> streak."7"
      end
    end
  end

  describe "registrations" do
    alias Misobo.Accounts.Registration

    @valid_attrs %{device_id: "some device_id"}
    @update_attrs %{device_id: "some updated device_id"}
    @invalid_attrs %{device_id: nil}

    def registration_fixture(attrs \\ %{}) do
      {:ok, registration} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_registration()

      registration
    end

    test "list_registrations/0 returns all registrations" do
      registration = registration_fixture()
      assert Accounts.list_registrations() == [registration]
    end

    test "get_registration!/1 returns the registration with given id" do
      registration = registration_fixture()
      assert Accounts.get_registration!(registration.id) == registration
    end

    test "create_registration/1 with valid data creates a registration" do
      assert {:ok, %Registration{} = registration} = Accounts.create_registration(@valid_attrs)
      assert registration.device_id == "some device_id"
    end

    test "create_registration/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_registration(@invalid_attrs)
    end

    test "update_registration/2 with valid data updates the registration" do
      registration = registration_fixture()

      assert {:ok, %Registration{} = registration} =
               Accounts.update_registration(registration, @update_attrs)

      assert registration.device_id == "some updated device_id"
    end

    test "update_registration/2 with invalid data returns error changeset" do
      registration = registration_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_registration(registration, @invalid_attrs)

      assert registration == Accounts.get_registration!(registration.id)
    end

    test "delete_registration/1 deletes the registration" do
      registration = registration_fixture()
      assert {:ok, %Registration{}} = Accounts.delete_registration(registration)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_registration!(registration.id) end
    end

    test "change_registration/1 returns a registration changeset" do
      registration = registration_fixture()
      assert %Ecto.Changeset{} = Accounts.change_registration(registration)
    end
  end
end
