defmodule Misobo.Communication.Message do
  @moduledoc """
  The Message context.
  """

  def get_signup_sms(otp) do
    "Your otp for misobo is #{otp}"
  end

  def generate_otp, do: Enum.random(1000..9999)
  def add_prefix(phone), do: "91#{phone}"
end
