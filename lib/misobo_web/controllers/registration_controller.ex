defmodule MisoboWeb.RegistrationController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.Registration
  alias Misobo.Accounts.User
  alias Misobo.Authentication

  @signup_event "SIGNUP"
  @signup_points Application.get_env(:misobo, Misobo.Env)[:signup_karma]

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  def create(conn, %{"device_id" => _device_id} = params) do
    with {:ok, {%Registration{} = registration, %User{} = user}} <-
           Accounts.create_registration_user(params),
         token <- Authentication.generate_token(registration) do
      spawn(fn -> Accounts.add_karma(user.id, @signup_points, @signup_event) end)

      response(conn, 201, %{
        data: %{
          msg: "user registered successfully",
          token: token,
          id: registration.id,
          user_id: user.id
        }
      })
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def show(conn, %{"registration_id" => registration_id}) do
    resp = Accounts.registration_catgories(registration_id)

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
