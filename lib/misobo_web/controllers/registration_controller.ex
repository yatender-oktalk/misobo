defmodule MisoboWeb.RegistrationController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.Registration
  alias Misobo.Accounts.User
  alias Misobo.Authentication
  alias Misobo.Communication.Message
  alias Misobo.Communication.SMSProvider

  @signup_event "SIGNUP"
  @signup_points Application.get_env(:misobo, Misobo.Env)[:signup_karma]

  def index(conn, _params) do
    response(conn, 200, :ok)
  end

  def create(conn, %{"device_id" => _device_id, "phone" => phone} = params) do
    with {:ok, %Registration{id: registration_id} = registration} <-
           Accounts.create_registration(params),
         user <- Accounts.get_user_by(%{phone: phone}),
         {otp, otp_valid_time} <- Message.generate_user_otp(user),
         {:ok, %User{} = user} <-
           Accounts.handle_user_create(user, %{
             phone: phone,
             otp: otp,
             otp_valid_time: otp_valid_time,
             otp_sent_phone: phone,
             registration_id: registration_id
           }),
         phone <- Message.add_prefix(phone),
         message <- Message.get_signup_sms(otp),
         :ok <- SMSProvider.send_sms(phone, message),
         token <- Authentication.generate_token(user) do
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
