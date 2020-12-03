defmodule Misobo.KarmasTest do
  use Misobo.DataCase

  alias Misobo.Karmas

  describe "karma_activities" do
    alias Misobo.Karmas.KarmaActivity

    @valid_attrs %{event_type: "some event_type", karma_points: 42}
    @update_attrs %{event_type: "some updated event_type", karma_points: 43}
    @invalid_attrs %{event_type: nil, karma_points: nil}

    def karma_activity_fixture(attrs \\ %{}) do
      {:ok, karma_activity} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Karmas.create_karma_activity()

      karma_activity
    end

    test "list_karma_activities/0 returns all karma_activities" do
      karma_activity = karma_activity_fixture()
      assert Karmas.list_karma_activities() == [karma_activity]
    end

    test "get_karma_activity!/1 returns the karma_activity with given id" do
      karma_activity = karma_activity_fixture()
      assert Karmas.get_karma_activity!(karma_activity.id) == karma_activity
    end

    test "create_karma_activity/1 with valid data creates a karma_activity" do
      assert {:ok, %KarmaActivity{} = karma_activity} = Karmas.create_karma_activity(@valid_attrs)
      assert karma_activity.event_type == "some event_type"
      assert karma_activity.karma_points == 42
    end

    test "create_karma_activity/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Karmas.create_karma_activity(@invalid_attrs)
    end

    test "update_karma_activity/2 with valid data updates the karma_activity" do
      karma_activity = karma_activity_fixture()

      assert {:ok, %KarmaActivity{} = karma_activity} =
               Karmas.update_karma_activity(karma_activity, @update_attrs)

      assert karma_activity.event_type == "some updated event_type"
      assert karma_activity.karma_points == 43
    end

    test "update_karma_activity/2 with invalid data returns error changeset" do
      karma_activity = karma_activity_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Karmas.update_karma_activity(karma_activity, @invalid_attrs)

      assert karma_activity == Karmas.get_karma_activity!(karma_activity.id)
    end

    test "delete_karma_activity/1 deletes the karma_activity" do
      karma_activity = karma_activity_fixture()
      assert {:ok, %KarmaActivity{}} = Karmas.delete_karma_activity(karma_activity)
      assert_raise Ecto.NoResultsError, fn -> Karmas.get_karma_activity!(karma_activity.id) end
    end

    test "change_karma_activity/1 returns a karma_activity changeset" do
      karma_activity = karma_activity_fixture()
      assert %Ecto.Changeset{} = Karmas.change_karma_activity(karma_activity)
    end
  end
end
