defmodule MisoboWeb.CategoryController do
  MisoboWeb.CategoryController

  @moduledoc """
  This module defines the categories releated stuff
  """
  use MisoboWeb, :controller

  alias Misobo.Categories

  def index(conn, _params) do
    data = Categories.get_categories_with_sub_categories()
    response(conn, 200, %{data: data})
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
