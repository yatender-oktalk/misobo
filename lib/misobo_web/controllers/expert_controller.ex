defmodule MisoboWeb.ExpertController do
  use MisoboWeb, :controller

  alias Misobo.Accounts.User
  alias Misobo.Experts
  alias Misobo.Experts.{Booking, Expert}

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
    with {true, parsed_date} <- Misobo.TimeUtils.valid_date_format?(date),
         booked_slots <- Experts.get_booked_slots_for_day(id, date),
         data <- Experts.get_available_slots(parsed_date, booked_slots) do
      response(conn, 200, data)
    else
      {false, error} ->
        error_response(conn, 400, error)
    end
  end

  def book_slot(
        conn,
        %{"start_time_unix" => start_time_unix, "expert_id" => expert_id} = _params
      ) do
    %{
      assigns: %{
        user: %User{id: id, karma_points: karma_points, is_enabled: is_enabled}
      }
    } = conn

    with {:enabled, true} <- {:enabled, is_enabled},
         {:slot, true} <-
           {:slot,
            Experts.slot_available?(%{start_time_unix: start_time_unix, expert_id: expert_id})},
         %Expert{consult_karma: karma} <- Experts.get_expert(expert_id),
         {:karma, true} <- {:karma, karma_points >= karma},
         {:ok, %Booking{} = booking} <-
           Experts.create_expert_booking(id, expert_id, start_time_unix, karma),
         {:ok, %User{}} <-
           Misobo.Accounts.deduct_karma(
             id,
             karma,
             "EXPERT_BOOKING:#{expert_id}:SLOT:#{start_time_unix}"
           ) do
      response(conn, 200, %{status: "success", data: booking})
    else
      {:karma, false} ->
        error_response(conn, 402, "User does not have sufficient karma")

      {:enabled, false} ->
        error_response(conn, 401, "User has not verified the phone")

      {:slot, false} ->
        error_response(conn, 400, "This slot is already booked")

      nil ->
        error_response(conn, 400, "error")

      {:error, _error} ->
        error_response(conn, 400, "bad request")
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
