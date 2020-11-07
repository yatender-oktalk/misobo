defmodule MisoboWeb.ExpertController do
  use MisoboWeb, :controller

  alias Misobo.Experts

  def index(conn, _params) do
    experts = Experts.list_experts()
    response(conn, 200, experts)
  end

  def show(conn, %{"id" => id} = _params) do
    expert = Experts.get_expert(id)
    response(conn, 200, %{data: expert})
  end

  def fetch(conn, %{"page" => page} = _params) do
    data = Experts.fetch_experts(page)
    response(conn, 200, Map.from_struct(data))
  end

  def get_categories(conn, _params) do
    data = Experts.list_expert_categories()
    response(conn, 200, data)
  end

  def expert_slots(conn, %{"id" => id, "date" => date}) do
    with {true, date} <- Misobo.TimeUtils.valid_date_format?(date),
         data <- Experts.get_available_slots(id, date) do
      response(conn, 200, data)
    else
      {false, error} ->
        error_response(conn, 400, error)
    end
  end

  # Private functions
  defp error_response(conn, status, message) do
    data = %{data: message}
    response(conn, status, data)
  end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
