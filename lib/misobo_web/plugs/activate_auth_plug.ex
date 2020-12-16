defmodule MisoboWeb.ActivateAuthPlug do
  @moduledoc """
  This module takes care of the authentication once the auth
  is successful, it'll fetch the user details and push it to
  the conn assings
  """
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias Misobo.Accounts.User

  @spec init(any) :: any
  def init(params) do
    params
  end

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(
        %Plug.Conn{assigns: %{user: %User{} = user}} = conn,
        _params
      ) do
    case user do
      %User{is_enabled: true} ->
        conn

      _ ->
        unauth(conn, %{data: "User has not verified the phone, unauthorized!"})
    end
  end

  defp unauth(conn, msg) do
    conn |> put_status(403) |> json(msg) |> halt
  end
end
