defmodule Misobo.Communication.CallProvider.ExotelTesla do
  @moduledoc """
  The Exotel communication interface.
  """
  @api_key "5e66e856a6885ef9939dacc005df7a17b1eb7a573ede0857"
  @api_token "c097ea7624d19350686d10079252e498223c7c39c03a363c"
  @subdomain "api.exotel.com"
  @sid "mangalpoojan1"

  use Tesla

  plug Tesla.Middleware.BaseUrl,
       "https://#{@api_key}:#{@api_token}@#{@subdomain}/v1/Accounts/#{@sid}"

  plug Tesla.Middleware.FormUrlencoded
end
