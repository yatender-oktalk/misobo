defmodule MisoboWeb.NonMatchingController do
  use MisoboWeb, :controller

  require Logger

  def capture(conn, _params) do
    capture_logs(conn)
    raise Phoenix.Router.NoRouteError, conn: conn, router: MisoboWeb.Router
  end

  def capture_logs(conn) do
    Logger.info(
      "No route found for #{inspect(conn.method)} #{inspect(conn.request_path)} body_params:
      #{inspect(conn.body_params)} params: #{inspect(conn.params)}"
    )
  end
end
