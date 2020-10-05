defmodule Misobo.Communication.SMSProvider.TextLocal do
  @moduledoc """
  The TextLocal communication interface.
  """
  alias Misobo.Communication.SMSProvider.TextLocalTesla

  def send_sms(_phone, _msg) do
    request = %{
      "apikey" => "xdKS7LOKnRI-lffJSFilOsRloyNIzedHigqZxgvqAg",
      "sender" => "MNPUSR",
      "numbers" => "8105139417",
      "message" => "random msg"
    }

    TextLocalTesla.post("/send/", request)
  end
end
