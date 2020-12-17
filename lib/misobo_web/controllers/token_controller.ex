defmodule MisoboWeb.TokenController do
  @moduledoc """
  token controller related to token modules
  """
  use MisoboWeb, :controller

  def generate(conn, %{"id" => id}) do
    resp =
      case Misobo.Accounts.get_user(id) do
        nil ->
          "User not found"

        %Misobo.Accounts.User{} = user ->
          Misobo.Authentication.generate_token(user)
      end

    response(conn, 200, %{data: resp})
  end

  def info(%{assigns: %{user: user}} = conn, _params) do
    response(conn, 200, user)
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
