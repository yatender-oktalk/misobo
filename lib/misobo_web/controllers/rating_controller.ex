defmodule MisoboWeb.RatingController do
  @moduledoc """
  This module defines the Ratings releated stuff
  """

  use MisoboWeb, :controller

  alias Misobo.Accounts.User
  alias Misobo.Experts
  alias Misobo.Experts.{Booking, Expert, Rating}

  def create(
        %{assigns: %{user: %User{id: user_id}}} = conn,
        %{
          "booking_id" => booking_id,
          "rating" => _rating
        } = params
      ) do
    with {:booking, %Booking{expert_id: expert_id, is_rated: is_rated} = booking} <-
           {:booking, Experts.get_booking(booking_id)},
         {:rated, true} <- {:rated, is_rated != true},
         {:ok, %Rating{}} <-
           Experts.create_rating(
             Map.merge(params, %{"user_id" => user_id, "expert_id" => expert_id})
           ),
         {:ok, %Booking{is_rated: true}} <- Experts.update_booking(booking, %{is_rated: true}),
         avg_rating <- Experts.get_average_rating(expert_id),
         %Expert{} = expert <- Experts.get_expert(expert_id),
         {:ok, %Expert{}} = Experts.update_expert(expert, %{rating: avg_rating}) do
      response(conn, 200, %{data: "Rating submitted"})
    else
      {:booking, nil} ->
        error_response(conn, 400, "Booking not found!")

      {:rated, false} ->
        error_response(conn, 400, "Booking already rated by user!")

      _ ->
        error_response(conn, 500, "unexpeced error")
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
