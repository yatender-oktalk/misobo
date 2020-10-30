defmodule MisoboWeb.ExpertController do
  use MisoboWeb, :controller

  alias Misobo.Experts
  # alias Misobo.Experts.Expert

  # import Misobo.Commons

  def index(conn, _params) do
    experts = Experts.list_experts()
    response(conn, 200, experts)
  end

  def fetch(conn, params) do
    data = Experts.fetch_experts(params)
    response(conn, 200, Map.from_struct(data))
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
