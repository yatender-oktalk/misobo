defmodule Misobo.Services.Notifications.NotificationText do
  @moduledoc """
  This module will take care of the generation of notification text
  """

  def notification_text(:daily_reminder) do
    %{heading: "Self care reminder", text: "Time for Daily care. Dive in now"}
  end
end
