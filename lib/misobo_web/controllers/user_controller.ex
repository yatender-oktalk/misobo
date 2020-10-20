defmodule MisoboWeb.UserController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.User
  alias Misobo.Communication.Message
  alias Misobo.Communication.SMSProvider

  import Misobo.Commons

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  def create(%{assigns: %{registration: registration}} = conn, %{"phone" => phone} = params) do
    with true <- Accounts.existing_registration?(registration),
         otp <- Message.generate_otp(),
         otp_valid_time <- get_otp_timeout(),
         params <- params |> Map.put("otp", otp) |> Map.put("otp_valid_time", otp_valid_time),
         params <- Map.put(params, "registration_id", registration.id),
         {:ok, %User{} = user} <- Accounts.create_user(params),
         phone <- Message.add_prefix(phone),
         message <- Message.get_signup_sms(otp),
         :ok <- SMSProvider.send_sms(phone, message) do
      response(conn, 201, %{data: user})
    else
      false ->
        error_response(
          conn,
          400,
          "Existing registration, please start a new registration for this device"
        )

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def verify(conn, %{"phone" => phone, "otp" => otp, "user_id" => id} = _params) do
    with %User{otp_valid_time: otp_timeout, otp: valid_otp, is_enabled: false, phone: ^phone} =
           user <-
           Accounts.get_user(id),
         {:sms, true} <- validate_otp(otp, valid_otp),
         true <- still_validate?(otp_timeout),
         {:ok, %User{} = user} <- Accounts.update_user(user, %{is_enabled: true}) do
      response(conn, 200, %{data: user})
    else
      %User{is_enabled: true} ->
        error_response(conn, 400, "User already verified")

      nil ->
        error_response(conn, 400, "User not found")

      {:sms, false} ->
        error_response(conn, 400, "Invalid OTP")

      false ->
        error_response(conn, 400, "OTP not valid now please generate new one")

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)

      _ ->
        error_response(conn, 400, "are you sure that request params are valid?")
    end
  end

  def update(conn, %{"id" => id} = _params) do
    with %User{} = user <- Accounts.get_user(id),
         {:ok, %User{} = updated_user} <- Accounts.update_user(user, conn.body_params) do
      response(conn, 200, %{data: updated_user})
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
