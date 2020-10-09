defmodule Misobo.Communication.SMSProvider.TextLocal do
  @moduledoc """
  The TextLocal communication interface.
  """
  alias Misobo.Communication.SMSProvider.TextLocalTesla
  @api_key Application.get_env(:misobo, Misobo.Communication.SMSProvider.TextLocal)[:api_key]

  def send_sms(phone, message) do
    request = %{
      "apikey" => @api_key,
      "sender" => "MNPUSR"
    }

    request =
      Map.new()
      |> Map.put("message", message)
      |> Map.put("numbers", phone)
      |> Map.merge(request)

    case TextLocalTesla.post("/send/", request) do
      {:ok, _} -> :ok
      _ -> :error
    end
  end
end
