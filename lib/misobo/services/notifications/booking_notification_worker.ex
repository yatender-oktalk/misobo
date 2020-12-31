defmodule Misobo.Services.Notifications.BookingNotificationWorker do
  @moduledoc """
  This module takes care of the booking related notifications before call
  """

  require Logger

  alias Misobo.Communication.{Message, SMSProvider}
  alias Misobo.Experts.Booking
  alias Misobo.Experts.Expert
  alias Misobo.Accounts.User

  @notification_provider Misobo.Services.Notifications.FCMIntegration

  def send_customer_reminders() do
    bookings = get_eligilbe_bookings()
    send_notifications(bookings)
    mark_notifications_sent(bookings)
  end

  def send_notifications([]), do: :ok

  def send_notifications_user(bookings) do
    send_customer_notifications(bookings)
    send_expert_notifications(bookings)
  end

  def send_customer_notifications(bookings) do
    bookings |> Enum.map(fn booking -> send_customer_notification(booking) end)
  end

  def send_customer_notification(%Booking{
        expert_id: expert_id,
        user_id: user_id,
        start_time_unix: start_time_unix
      }) do
    case get_user_and_expert(user_id, expert_id) do
      {nil, nil, nil} ->
        Logger.info("user or expert not avaialable")

      {expert_name, token, phone} ->
        msg = Message.get_customer_booking_msg_precall(start_time_unix, expert_name)

        case token do
          nil ->
            phone
            |> Message.add_prefix()
            |> SMSProvider.send_sms(msg)

          _ ->
            msg = %{heading: "Expert call in sometime", text: msg}
            @notification_provider.send_many_notifications([token], msg)
        end
    end
  end

  def send_expert_notifications(bookings) do
    bookings |> Enum.map(fn booking -> send_expert_notification(booking) end)
  end

  def send_expert_notification(%Booking{start_time_unix: start_time_unix, expert_id: expert_id}) do
    msg = Message.get_expert_booking_msg_precall(start_time_unix)

    case Misobo.Experts.get_expert(expert_id) do
      nil ->
        :ok

      %Expert{phone: phone} ->
        phone
        |> Message.add_prefix()
        |> SMSProvider.send_sms(msg)
    end
  end

  def get_user_and_expert(user_id, expert_id) do
    case {Misobo.Experts.get_expert(expert_id), Misobo.Accounts.get_user(user_id)} do
      {%Expert{name: name}, %User{fcm_registration_token: token, phone: phone}} ->
        {name, token, phone}

      _ ->
        {nil, nil, nil}
    end
  end

  def mark_notifications_sent([]), do: :ok

  def mark_notifications_sent(bookings) do
    Enum.map(bookings, fn booking ->
      booking.booking_id
    end)
  end

  def get_eligilbe_bookings() do
    start_time = DateTime.utc_now() |> DateTime.add(19739 + 600)
    end_time = DateTime.utc_now() |> DateTime.add(19801 + 600)

    Logger.info(
      "Fetching bookings for time between #{inspect(start_time)} and #{inspect(end_time)}"
    )

    Misobo.Experts.get_booking_between_duration(start_time, end_time)
  end
end
