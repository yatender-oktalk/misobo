defmodule MisoboWeb.AccountController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.User
  alias Misobo.Authentication
  alias Misobo.Communication.Message
  alias Misobo.Communication.SMSProvider

  import Misobo.Commons

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  def create(conn, %{"phone" => phone} = params) do
    with otp <- Message.generate_otp(),
         otp_valid_time <- get_otp_timeout(),
         params <- params |> Map.put("otp", otp) |> Map.put("otp_valid_time", otp_valid_time),
         {:ok, %User{} = _user} <- Accounts.create_user(params),
         phone <- Message.add_prefix(phone),
         message <- Message.get_signup_sms(otp),
         :ok <- SMSProvider.send_sms(phone, message) do
      response(conn, 201, %{data: "user created successfully"})
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def login(conn, %{"phone" => phone, "otp" => otp} = _params) do
    with %User{otp_valid_time: otp_timeout, otp: valid_otp} = user <-
           Accounts.get_user_by(%{phone: phone}),
         {:sms, true} <- validate_otp(otp, valid_otp),
         true <- still_validate?(otp_timeout),
         {:ok, %User{} = user} <- Accounts.update_user(user, %{is_enabled: true}),
         token <- Authentication.generate_token(user) do
      response(conn, 200, %{data: user, token: token})
    else
      nil ->
        error_response(conn, 400, "User not found")

      {:sms, false} ->
        error_response(conn, 400, "invalid OTP")

      false ->
        error_response(conn, 400, "OTP not valid now please generate new one")

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

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
