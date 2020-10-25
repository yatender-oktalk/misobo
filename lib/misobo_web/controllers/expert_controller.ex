defmodule MisoboWeb.ExpertController do
  use MisoboWeb, :controller

  # alias Misobo.Experts
  # alias Misobo.Experts.Expert

  # import Misobo.Commons

  def index(conn, _params) do
    # _experts = Experts.list_experts(params)
    response(conn, 200, :ok)
  end

  # Private functions
  # defp error_response(conn, status, message) do
  #   data = %{data: message}
  #   response(conn, status, data)
  # end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
