defmodule MisoboWeb.RegistrationController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.Registration
  alias Misobo.Authentication

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  def create(conn, %{"device_id" => _device_id} = params) do
    with {:ok, %Registration{} = registration} <- Accounts.create_registration(params),
         token <- Authentication.generate_token(registration) do
      response(conn, 201, %{data: %{msg: "user registered successfully", token: token}})
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
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
