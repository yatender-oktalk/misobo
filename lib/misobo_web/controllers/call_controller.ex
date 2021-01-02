defmodule MisoboWeb.CallController do
  @moduledoc """
  This module defines the blog releated stuff
  """
  use MisoboWeb, :controller
  require Logger

  def update(conn, params) do
    Logger.info("Receiving the callback from exotel #{inspect(params)}")
    response(conn, 200, %{data: :ok, msg: :ok})
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
