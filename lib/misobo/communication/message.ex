defmodule Misobo.Communication.Message do
  @moduledoc """
  The Message context.
  """

  def get_signup_sms(otp) do
    "Thank you for registering with Misobo your OTP is #{otp}"
  end

  def generate_otp, do: Enum.random(1000..9999)
  def add_prefix(phone), do: "91#{phone}"
end
