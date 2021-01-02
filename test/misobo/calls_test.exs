defmodule Misobo.CallsTest do
  use Misobo.DataCase

  alias Misobo.Calls

  describe "calls" do
    alias Misobo.Calls.Call

    @valid_attrs %{
      account_sid: "some account_sid",
      answered_by: "some answered_by",
      caller_name: "some caller_name",
      date_created: ~N[2010-04-17 14:00:00],
      date_updated: ~N[2010-04-17 14:00:00],
      direction: "some direction",
      duration: 42,
      end_time: ~N[2010-04-17 14:00:00],
      forwared_from: "some forwared_from",
      from: "some from",
      parent_call_sid: "some parent_call_sid",
      phone_number_sid: "some phone_number_sid",
      price: "120.5",
      recording_url: "some recording_url",
      sid: "some sid",
      start_time: ~N[2010-04-17 14:00:00],
      status: "some status",
      to: "some to",
      url: "some url"
    }
    @update_attrs %{
      account_sid: "some updated account_sid",
      answered_by: "some updated answered_by",
      caller_name: "some updated caller_name",
      date_created: ~N[2011-05-18 15:01:01],
      date_updated: ~N[2011-05-18 15:01:01],
      direction: "some updated direction",
      duration: 43,
      end_time: ~N[2011-05-18 15:01:01],
      forwared_from: "some updated forwared_from",
      from: "some updated from",
      parent_call_sid: "some updated parent_call_sid",
      phone_number_sid: "some updated phone_number_sid",
      price: "456.7",
      recording_url: "some updated recording_url",
      sid: "some updated sid",
      start_time: ~N[2011-05-18 15:01:01],
      status: "some updated status",
      to: "some updated to",
      url: "some updated url"
    }
    @invalid_attrs %{
      account_sid: nil,
      answered_by: nil,
      caller_name: nil,
      date_created: nil,
      date_updated: nil,
      direction: nil,
      duration: nil,
      end_time: nil,
      forwared_from: nil,
      from: nil,
      parent_call_sid: nil,
      phone_number_sid: nil,
      price: nil,
      recording_url: nil,
      sid: nil,
      start_time: nil,
      status: nil,
      to: nil,
      url: nil
    }

    def call_fixture(attrs \\ %{}) do
      {:ok, call} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Calls.create_call()

      call
    end

    test "list_calls/0 returns all calls" do
      call = call_fixture()
      assert Calls.list_calls() == [call]
    end

    test "get_call!/1 returns the call with given id" do
      call = call_fixture()
      assert Calls.get_call!(call.id) == call
    end

    test "create_call/1 with valid data creates a call" do
      assert {:ok, %Call{} = call} = Calls.create_call(@valid_attrs)
      assert call.account_sid == "some account_sid"
      assert call.answered_by == "some answered_by"
      assert call.caller_name == "some caller_name"
      assert call.date_created == ~N[2010-04-17 14:00:00]
      assert call.date_updated == ~N[2010-04-17 14:00:00]
      assert call.direction == "some direction"
      assert call.duration == 42
      assert call.end_time == ~N[2010-04-17 14:00:00]
      assert call.forwared_from == "some forwared_from"
      assert call.from == "some from"
      assert call.parent_call_sid == "some parent_call_sid"
      assert call.phone_number_sid == "some phone_number_sid"
      assert call.price == Decimal.new("120.5")
      assert call.recording_url == "some recording_url"
      assert call.sid == "some sid"
      assert call.start_time == ~N[2010-04-17 14:00:00]
      assert call.status == "some status"
      assert call.to == "some to"
      assert call.url == "some url"
    end

    test "create_call/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Calls.create_call(@invalid_attrs)
    end

    test "update_call/2 with valid data updates the call" do
      call = call_fixture()
      assert {:ok, %Call{} = call} = Calls.update_call(call, @update_attrs)
      assert call.account_sid == "some updated account_sid"
      assert call.answered_by == "some updated answered_by"
      assert call.caller_name == "some updated caller_name"
      assert call.date_created == ~N[2011-05-18 15:01:01]
      assert call.date_updated == ~N[2011-05-18 15:01:01]
      assert call.direction == "some updated direction"
      assert call.duration == 43
      assert call.end_time == ~N[2011-05-18 15:01:01]
      assert call.forwared_from == "some updated forwared_from"
      assert call.from == "some updated from"
      assert call.parent_call_sid == "some updated parent_call_sid"
      assert call.phone_number_sid == "some updated phone_number_sid"
      assert call.price == Decimal.new("456.7")
      assert call.recording_url == "some updated recording_url"
      assert call.sid == "some updated sid"
      assert call.start_time == ~N[2011-05-18 15:01:01]
      assert call.status == "some updated status"
      assert call.to == "some updated to"
      assert call.url == "some updated url"
    end

    test "update_call/2 with invalid data returns error changeset" do
      call = call_fixture()
      assert {:error, %Ecto.Changeset{}} = Calls.update_call(call, @invalid_attrs)
      assert call == Calls.get_call!(call.id)
    end

    test "delete_call/1 deletes the call" do
      call = call_fixture()
      assert {:ok, %Call{}} = Calls.delete_call(call)
      assert_raise Ecto.NoResultsError, fn -> Calls.get_call!(call.id) end
    end

    test "change_call/1 returns a call changeset" do
      call = call_fixture()
      assert %Ecto.Changeset{} = Calls.change_call(call)
    end
  end
end
