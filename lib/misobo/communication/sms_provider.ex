defmodule Misobo.Communication.SMSProvider do
  @moduledoc """
  This module provides the behaviours related to SMS
  """

  @adapter Application.get_env(:misobo, :communication)[:sms]

  def send_sms(phone, msg) do
    @adapter.send_sms(phone, msg)
  end
end
