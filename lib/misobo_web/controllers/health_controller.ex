defmodule MisoboWeb.HealthController do
  use MisoboWeb, :controller

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
