defmodule MisoboWeb.CategoryController do
  @moduledoc """
  This module defines the categories releated stuff
  """
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.Registration
  alias Misobo.Categories
  alias Misobo.Experts

  def index(conn, _params) do
    data = Categories.get_categories_with_sub_categories()
    response(conn, 200, %{data: data})
  end

  def category_experts(conn, %{"id" => id} = params) do
    data = Experts.get_experts_for_category(id, params["page"])
    response(conn, 200, Map.from_struct(data))
  end

  def update_registration_categories(
        conn,
        %{"registration_id" => registration_id, "categories" => categories} = _params
      ) do
    with registration <- Accounts.registration_categories_preloaded(registration_id),
         {:ok, %Registration{}} <-
           Accounts.upsert_registration_categories(registration, categories) do
      response(conn, 200, %{data: "Successfully updated!"})
    else
      nil ->
        error_response(conn, 400, "registration not found")

      _err ->
        error_response(conn, 500, "something unexpected occured")
    end

    response(conn, 200, :ok)
  end

  @spec update_registration_sub_categories(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update_registration_sub_categories(
        conn,
        %{"registration_id" => registration_id, "sub_categories" => sub_categories} = _params
      ) do
    with registration <- Accounts.registration_sub_categories_preloaded(registration_id),
         {:ok, %Registration{}} <-
           Accounts.upsert_registration_sub_categories(registration, sub_categories) do
      response(conn, 200, %{data: "Successfully updated!"})
    else
      nil ->
        error_response(conn, 400, "registration not found")

      _err ->
        error_response(conn, 500, "something unexpected occured")
    end

    response(conn, 200, :ok)
  end

  def registration_sub_categories(conn, %{"registration_id" => registration_id}) do
    resp = Accounts.registration_sub_catgories(registration_id)

    case resp do
      %Registration{} = registration ->
        response(conn, 200, %{data: registration})

      _err ->
        error_response(conn, 400, "registration not found")
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
