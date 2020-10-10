defmodule Misobo.Communication.SMSProvider.TextLocalTesla do
  @moduledoc """
  The TextLocal communication interface.
  """
  use Tesla
  plug Tesla.Middleware.BaseUrl, "https://api.textlocal.in"
  plug Tesla.Middleware.FormUrlencoded
end
