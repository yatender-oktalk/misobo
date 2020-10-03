defmodule Misobo.Communication.SMSProvider.TextLocalMock do
  @moduledoc """
   The TextLocal Mock communication interface.
   """

   def send_sms(_phone, _msg) do
     :ok
   end
 end
