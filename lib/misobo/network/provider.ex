defmodule Misobo.Network.PG.Provider do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://api.razorpay.com/v1"
  plug Tesla.Middleware.Logger
  # static configuration
  plug Tesla.Middleware.BasicAuth,
    username: "rzp_live_2N116OfoXntg9j",
    password: "mP4SFPAPLaH7DoluqScGbNVc"

  plug Tesla.Middleware.JSON

  def create_order(params) do
    case post("/orders", params) do
      {:ok, %Tesla.Env{body: %{error: error}} = _response} ->
        {:error, error}

      {:ok, %Tesla.Env{} = response} ->
        {:ok, response.body}

      {:error, err} ->
        Logger.error(err)
        {:error, "PG call failed"}
    end
  end

  def capture_payment(payment_id, params) do
    case post("/payments/#{payment_id}/capture", params) do
      {:ok, %Tesla.Env{body: %{error: error}} = _response} ->
        {:error, error}

      {:ok, %Tesla.Env{} = response} ->
        {:ok, response.body}

      {:error, err} ->
        Logger.error(err)
        {:error, "capture failed"}
    end
  end
end
