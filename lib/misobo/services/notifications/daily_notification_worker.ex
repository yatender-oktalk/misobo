defmodule Misobo.Services.Notifications.DailyNotificationWorker do
  @moduledoc """
  This module takes care of the daily notifications to user
  """

  require Logger

  @notification_provider Misobo.Services.Notifications.FCMIntegration
  alias Misobo.Services.Notifications.NotificationText

  def send_reminder() do
    Logger.debug("Sending reminder..")

    get_minutes_now()
    |> get_eligible_users()
    |> @notification_provider.send_many_notifications(get_text())
  end

  # Time conversion
  def get_minutes_now() do
    time = Misobo.TimeUtils.utc_to_indian_timezone() |> DateTime.to_time()
    time.hour * 60 + time.minute
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
