defmodule MisoboWeb.RegistrationAuthPlug do
  @moduledoc """
  This module takes care of the authentication once the auth
  is successful, it'll fetch the registration details and push it to
  the conn assings
  """
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias Misobo.Accounts
  alias Misobo.Accounts.Registration

  @spec init(any) :: any
  def init(params) do
    params
  end

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(%Plug.Conn{req_headers: headers} = conn, _params) do
    with headers <- Map.new(headers),
         {:ok, %{id: id} = _data} <- Misobo.Authentication.verify(headers["token"]),
         %Misobo.Accounts.User{id: user_id, registration_id: registration_id} = user <-
           Accounts.get_user(id),
         registration = Accounts.get_registration(registration_id),
         true <-
           id ==
             user_id do
      spawn(fn -> Misobo.Accounts.handle_login_streak(user) end)

      conn |> assign(:user, user) |> assign(:registration, registration)
    else
      {:error, :invalid} -> unauth(conn, %{data: "unauthorized token"})
      false -> unauth(conn, %{data: "invalid token for this user"})
      nil -> unauth(conn, %{data: "invalid user"})
      _ -> unauth(conn, %{data: "unauthorized!"})
    end
  end

  defp unauth(conn, msg) do
    conn |> put_status(403) |> json(msg) |> halt
  end
end
