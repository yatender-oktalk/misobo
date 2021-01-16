defmodule Misobo.Communication.SMSProvider.TextLocal do
  @moduledoc """
  The TextLocal communication interface.
  """

  require Logger

  alias Misobo.Communication.SMSProvider.TextLocalTesla
  @api_key Application.get_env(:misobo, Misobo.Communication.SMSProvider.TextLocal)[:api_key]

  def send_sms(phone, message) do
    request = %{
      "apikey" => @api_key,
      "sender" => "MNPGRP"
    }

    request =
      Map.new()
      |> Map.put("message", message)
      |> Map.put("numbers", phone)
      |> Map.merge(request)

    case TextLocalTesla.post("/send/", request) do
      {:ok, _} ->
        :ok

      err ->
        Logger.error("Error while sending OTP #{inspect(err)}")
        :error
    end
  end
end
