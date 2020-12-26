defmodule Misobo.Services.Notifications.FCMIntegration do
  @moduledoc """
  This module is the integration of FCM
  """

  alias Pigeon.FCM

  require Logger

  def send_many_notifications([], _text) do
    Logger.info("No Eligible candidate at #{inspect(DateTime.utc_now())}")
  end

  def send_many_notifications(fcm_registrations, text) do
    Logger.info("Sending notifications Eligible candidate at #{inspect(DateTime.utc_now())}")

    on_response = fn n ->
      case n.status do
        :success ->
          Logger.info("Response for notification at #{inspect(n.response)}")

          :ok

        # Handle updated regids, remove bad ones, etc
        :unauthorized ->
          Logger.error("unautorized")
          :error

        # Bad FCM key
        error ->
          Logger.error("Error in notification at #{inspect(error)}")
      end
    end

    fcm_registrations
    |> FCM.Notification.new(text)
    |> FCM.push(on_response: on_response)
  end
end
