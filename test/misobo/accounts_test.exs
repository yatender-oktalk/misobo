defmodule Misobo.AccountsTest do
  use Misobo.DataCase

  alias Misobo.Accounts

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
      is_enabled: nil,
      karma_points: nil,
      name: nil,
      otp: nil,
      phone: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
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
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.dob == ~N[2010-04-17 14:00:00]
      assert user.is_enabled == true
      assert user.karma_points == 42
      assert user.name == "some name"
      assert user.otp == 42
      assert user.phone == "90909090"
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
end
