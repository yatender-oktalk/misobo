defmodule MisoboWeb.TermsController do
  @moduledoc """
  This module takes care of the terms and conditions
  """
  use MisoboWeb, :controller

  def index(conn, _params) do
    data = Misobo.Terms.list_terms_conditions()
    response(conn, 200, data)
  end

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> html(data)
  end
end
