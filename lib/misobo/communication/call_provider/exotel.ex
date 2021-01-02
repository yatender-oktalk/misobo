defmodule Misobo.Communication.CallProvider.Exotel do
  @moduledoc """
  This module is the interface of the Exotel API
  """
  alias Misobo.Communication.CallProvider.ExotelTesla
  require Logger

  def connect_call(phone1, phone2) do
    request = %{
      From: "0#{phone1}",
      To: "0#{phone2}",
      CallerId: "01140847712",
      CallType: "trans",
      TimeLimit: 30
    }

    case ExotelTesla.post("/Calls/connect.json", request) do
      {:ok, resp} ->
        case resp.status do
          200 ->
            body = Jason.decode!(resp.body)["Call"]
            Misobo.Calls.create_call(body)
            :ok

          _ ->
            Logger.error("Could not place the call for #{inspect(phone1)} and #{inspect(phone2)}")
            :error
        end

      err ->
        Logger.error("Error occured while placing the call #{inspect(err)}")
        :error
    end
  end
end
