defmodule Misobo.Communication.Message do
  @moduledoc """
  The Message context.
  """

  def get_signup_sms(otp) do
    "Thank you for registering with Misobo your OTP is #{otp}"
  end

  def generate_otp, do: Enum.random(1000..9999)

  def generate_user_otp(nil) do
    {generate_otp(), Misobo.Commons.get_otp_timeout()}
  end

  def generate_user_otp(%Misobo.Accounts.User{otp: _otp, otp_valid_time: nil}) do
    generate_user_otp(nil)
  end

  def generate_user_otp(%Misobo.Accounts.User{otp: otp, otp_valid_time: otp_valid_time}) do
    case NaiveDateTime.diff(
           otp_valid_time,
           NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)
         ) >=
           120 do
      true -> {otp, otp_valid_time}
      _ -> generate_user_otp(nil)
    end
  end

  def add_prefix(phone), do: "91#{phone}"
end
