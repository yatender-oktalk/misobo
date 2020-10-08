defmodule Misobo.Communication.SMSProvider.TextLocal do
  @moduledoc """
  The TextLocal communication interface.
  """
  alias Misobo.Communication.SMSProvider.TextLocalTesla

  def send_sms(phone, message) do
    request = %{
      "apikey" => "xdKS7LOKnRI-lffJSFilOsRloyNIzedHigqZxgvqAg",
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
