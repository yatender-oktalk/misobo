defmodule MisoboWeb.AuthPlug do
  @moduledoc """
  This module takes care of the authentication once the auth
  is successful, it'll fetch the user details and push it to
  the conn assings
  """
  import Plug.Conn
  import Phoenix.Controller, only: [json: 2]
  alias Misobo.Accounts
  alias Misobo.Accounts.User

  @spec init(any) :: any
  def init(params) do
    params
  end

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(%Plug.Conn{req_headers: headers} = conn, _params) do
    with headers <- Map.new(headers),
         {:ok, %{id: id} = _data} <- Misobo.Authentication.verify(headers["token"]),
         %User{id: user_id, is_enabled: true} = user <- Accounts.get_user(id),
         true <- id == user_id do
      # handle the logic of user login streak here
      spawn(fn -> Misobo.Accounts.handle_login_streak(user) end)
      conn |> assign(:token_info, user)
    else
      {:error, :invalid} -> unauth(conn, %{data: "unauthorized token"})
      false -> unauth(conn, %{data: "invalid token for this user"})
      %User{is_enabled: false} -> unauth(conn, %{data: "User not enabled"})
      nil -> unauth(conn, %{data: "invalid user"})
      _ -> unauth(conn, %{data: "unauthorized!"})
    end
  end

  defp unauth(conn, msg) do
    conn |> put_status(403) |> json(msg) |> halt
  end
end
