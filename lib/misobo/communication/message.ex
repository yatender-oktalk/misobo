defmodule Misobo.Communication.Message do
  @moduledoc """
  The Message context.
  """

  alias Misobo.TimeUtils

  def get_signup_sms(otp) do
    "Thank you for registering with Misobo your OTP is #{otp}"
  end

  def get_expert_booking_msg(start_time_unix) do
    {date, time} = convert_unix_to_date_time(start_time_unix)
    "You have got a new booking on #{date} at #{time} from Misobo"
  end

  def get_customer_booking_msg(start_time_unix, expert_name) do
    {date, time} = convert_unix_to_date_time(start_time_unix)
    "You have booked a call with #{expert_name} is on #{date} at #{time} on Misobo"
  end

  def get_customer_booking_msg_precall(start_time_unix, expert_name) do
    {_date, time} = convert_unix_to_date_time(start_time_unix)
    "Your call with #{expert_name} is at #{time} today from Misobo"
  end

  def get_expert_booking_msg_precall(start_time_unix) do
    {_date, time} = convert_unix_to_date_time(start_time_unix)
    "Your call is at #{time} today from Misobo"
  end

  defp convert_unix_to_date_time(start_time_unix) do
    TimeUtils.get_unix_to_date_time(start_time_unix)
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
