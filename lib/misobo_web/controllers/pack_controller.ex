defmodule MisoboWeb.PackController do
  use MisoboWeb, :controller

  alias Misobo.Packs

  def index(conn, _params) do
    response(conn, 200, Packs.activated_packs())
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
