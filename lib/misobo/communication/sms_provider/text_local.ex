defmodule Misobo.Communication.SMSProvider.TextLocal do
 @moduledoc """
  The TextLocal communication interface.
  """

  def send_sms(_phone, _msg) do
    :ok
  end
end
