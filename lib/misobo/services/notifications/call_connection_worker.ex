defmodule Misobo.Services.Notifications.CallConnectionWorker do
  @moduledoc """
  This module takes care of the connecting the calls together once call with expert is scheduled
  """

  require Logger
  alias Misobo.Experts.Booking
  alias Misobo.Experts.Expert
  alias Misobo.Accounts.User

  @call_provider Misobo.Communication.CallProvider
  def connect_call() do
    Logger.info("Starting the connect calls at #{inspect(DateTime.utc_now())}")

    get_eligilbe_bookings() |> make_calls()
  end

  def make_calls([]) do
    Logger.info("No booking to connect call found at #{inspect(DateTime.utc_now())}")
  end

  def make_calls(bookings) do
    Enum.map(bookings, fn booking ->
      make_call(booking)
    end)
  end

  def make_call(%Booking{expert_id: expert_id, user_id: user_id}) do
    case get_user_and_expert(user_id, expert_id) do
      {nil, nil} ->
        Logger.info("User or expert not found for given ids")

      {expert_phone, user_phone} ->
        connect_phone_call(expert_phone, user_phone)
    end
  end

  def connect_phone_call(expert_phone, user_phone) do
    Logger.info(
      "Connecting phone call with Expert #{inspect(expert_phone)} and #{inspect(user_phone)}"
    )

    @call_provider.connect_call(expert_phone, user_phone)
  end

  def get_user_and_expert(user_id, expert_id) do
    case {Misobo.Experts.get_expert(expert_id), Misobo.Accounts.get_user(user_id)} do
      {%Expert{phone: expert_phone}, %User{phone: user_phone}} ->
        {expert_phone, user_phone}

      _ ->
        {nil, nil}
    end
  end

  def get_eligilbe_bookings() do
    start_time = DateTime.utc_now() |> DateTime.add(19800 - 5)
    end_time = DateTime.utc_now() |> DateTime.add(19801 + 5)

    Logger.info(
      "Fetching bookings for time between #{inspect(start_time)} and #{inspect(end_time)}"
    )

    Misobo.Experts.get_booking_between_duration(start_time, end_time)
  end
end
