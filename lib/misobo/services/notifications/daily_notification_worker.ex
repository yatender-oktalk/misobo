defmodule Misobo.Services.Notifications.DailyNotificationWorker do
  @moduledoc """
  This module takes care of the daily notifications to user
  """

  use GenServer

  @notification_provider Misobo.Services.Notifications.FCMIntegration
  alias Misobo.Services.Notifications.NotificationText

  def start_link(opts \\ []) do
    IO.inspect("starting..")
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(_opts) do
    state = %{}
    {:ok, state}
  end

  def handle_call(_, _from, state) do
    resp = %{}
    {:reply, resp, state}
  end

  def handle_cast(_, state) do
    {:noreply, state}
  end

  # Time conversion
  def get_minutes_now() do
    time = Misobo.TimeUtils.utc_to_indian_timezone() |> DateTime.to_time()
    time.hour * 60 + time.minute
  end

  def send_reminder() do
    get_minutes_now()
    |> get_eligible_users()
    |> @notification_provider.send_many_notifications(get_text())
  end

  def get_text() do
    NotificationText.notification_text(:daily_reminder)
  end

  def get_eligible_users(minutes_now) do
    minutes_now
    |> Misobo.Accounts.get_all_users_by()
    |> Enum.map(fn user -> user.fcm_registration_token end)
  end
end
