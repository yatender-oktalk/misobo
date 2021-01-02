defmodule MisoboWeb.UserController do
  use MisoboWeb, :controller

  alias Misobo.Accounts
  alias Misobo.Accounts.User
  alias Misobo.Communication.Message
  alias Misobo.Communication.SMSProvider

  import Misobo.Commons

  def index(conn, %{"id" => id}) do
    case Accounts.get_user_profile(id) do
      nil -> response(conn, 200, %{data: %{}, msg: "user not found"})
      user -> response(conn, 200, %{data: user, msg: "ok"})
    end
  end

  def register_phone(
        %{assigns: %{registration: registration}} = conn,
        %{"phone" => phone} = params
      ) do
    with otp <- Message.generate_otp(),
         otp_valid_time <- get_otp_timeout(),
         params <- params |> Map.put("otp", otp) |> Map.put("otp_valid_time", otp_valid_time),
         user <- Accounts.get_user_by(%{registration_id: registration.id}),
         {:ok, %User{} = user} <- Accounts.update_user(user, params),
         phone <- Message.add_prefix(phone),
         message <- Message.get_signup_sms(otp),
         :ok <- SMSProvider.send_sms(phone, message) do
      response(conn, 201, %{data: user})
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def verify(
        %{assigns: %{user: user}} = conn,
        %{"phone" => user_otp_sent_phone, "otp" => otp, "id" => id} = _params
      ) do
    with %User{
           otp_valid_time: otp_timeout,
           otp: valid_otp,
           registration_id: registration_id,
           otp_sent_phone: otp_sent_phone
         } <- user,
         {:phone, true} <- {:phone, otp_sent_phone == user_otp_sent_phone},
         {:sms, true} <- validate_otp(otp, valid_otp),
         true <- still_validate?(otp_timeout),
         {:ok, %User{} = user} <-
           Accounts.update_user(user, %{
             is_enabled: true,
             registration_id: id,
             phone: otp_sent_phone
           }),
         registration_categories <- Accounts.registration_sub_catgories(registration_id),
         {:user, is_new_user} <- {:user, registration_categories.sub_categories == []},
         {_, nil} <-
           Misobo.Categories.update_registration_sub_categories_registration(registration_id, id) do
      response(conn, 200, %{data: user, is_new_user: is_new_user})
    else
      nil ->
        error_response(conn, 400, "User not found")

      {:sms, false} ->
        error_response(conn, 400, "Invalid OTP")

      {:phone, false} ->
        error_response(conn, 400, "Phone OTP sent is differnt than you are verifying")

      false ->
        generate_otp(user, user_otp_sent_phone)
        error_response(conn, 400, "OTP not valid now please enter the new received OTP")

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)

      err ->
        IO.inspect(err)
        error_response(conn, 400, "are you sure that request params are valid?")
    end
  end

  def update(%{assigns: %{user: %User{id: user_id}}} = conn, %{"id" => id} = _params) do
    with true <- to_string(user_id) == id,
         %User{} = user <- Accounts.get_user(id),
         {:ok, %User{} = _user} <-
           Accounts.update_user(user, conn.body_params) do
      response(conn, 200, %{data: "success"})
    else
      false ->
        error_response(conn, 400, "bad request, not allow to modify this user's data")

      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def calculate_bmi(
        %{assigns: %{user: %User{id: user_id}}} = conn,
        %{"height" => height, "weight" => weight, "user_id" => _id} = _params
      ) do
    with {:ok, %{"bmi" => bmi, "result" => result} = data} <-
           Accounts.calculate_bmi(height, weight),
         %User{} = user <- Accounts.get_user(user_id),
         {:ok, %User{}} <-
           Accounts.update_user(user, %{
             height: height,
             weight: weight,
             bmi: bmi,
             bmi_checked_at: Misobo.TimeUtils.utc_to_indian_timezone(DateTime.utc_now()),
             result: result
           }) do
      response(conn, 200, %{data: data})
    else
      {:error, changeset} ->
        error =
          Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

        error_response(conn, 400, error)
    end
  end

  def expert_bookings(conn, %{"id" => id, "page" => page} = _params) do
    bookings = Misobo.Experts.user_expert_bookings(id, page)
    response(conn, 200, %{data: Map.from_struct(bookings)})
  end

  def unrated_bookings(conn, %{"id" => id}) do
    bookings = Misobo.Experts.unrated_bookings(id)
    response(conn, 200, %{data: bookings})
  end

  def send_sms(%{assigns: %{user: %User{registration_id: id, id: user_id} = user}} = conn, %{
        "phone" => phone
      }) do
    :ok = regenerate_otp(user, phone)

    response(conn, 200, %{
      data: %{
        id: id,
        msg: "Successfully sent SMS",
        user_id: user_id
      }
    })
  end

  # Private functions
  defp generate_otp(user, phone) do
    # Again update the OTP and valid time
    {otp, otp_valid_time} = Message.generate_user_otp(user)

    {:ok, %User{} = _user} =
      Accounts.update_user(user, %{phone: phone, otp: otp, otp_valid_time: otp_valid_time})

    phone = Message.add_prefix(phone)
    message = Message.get_signup_sms(otp)
    :ok = SMSProvider.send_sms(phone, message)
  end

  defp regenerate_otp(user, phone) do
    # Again update the OTP and valid time
    {otp, otp_valid_time} = Message.generate_user_otp(user)

    {:ok, %User{} = _user} =
      Accounts.update_user(user, %{
        otp: otp,
        otp_valid_time: otp_valid_time,
        otp_sent_phone: phone
      })

    phone = Message.add_prefix(phone)
    message = Message.get_signup_sms(otp)
    :ok = SMSProvider.send_sms(phone, message)
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
