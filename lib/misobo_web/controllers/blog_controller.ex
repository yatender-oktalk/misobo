defmodule MisoboWeb.BlogController do
  @moduledoc """
  This module defines the blog releated stuff
  """
  use MisoboWeb, :controller
  alias Misobo.Blogs

  def index(conn, _params) do
    response(conn, 200, %{data: Blogs.fetch_blogs(), msg: :ok})
  end

  def show(conn, %{"id" => id}) do
    case Blogs.get_blog(id) do
      nil -> response(conn, 200, %{data: %{}, msg: "blog not found"})
      blog -> response(conn, 200, %{data: blog, msg: "ok"})
    end
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
