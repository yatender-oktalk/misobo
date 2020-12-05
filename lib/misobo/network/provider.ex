defmodule Misobo.Network.PG.Provider do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://api.razorpay.com/v1"
  plug Tesla.Middleware.Logger
  # static configuration
  plug Tesla.Middleware.BasicAuth,
    username: "rzp_test_dTvKn9msFUzE7U",
    password: "tduHCVfxg96EJrHTK8v8dqMt"

  plug Tesla.Middleware.JSON

  def create_order(params) do
    case post("/orders", params) do
      {:ok, %Tesla.Env{body: %{error: error}} = response} ->
        {:error, error}

      {:ok, %Tesla.Env{} = response} ->
        {:ok, response.body}

      {:error, err} ->
        Logger.error(err)
        {:error, "PG call failed"}
    end
  end
end
