defmodule Misobo.Commons do
  @moduledoc """
  This module takes care of the common methods
  """

  @timeout_secs 1800

  def get_otp_timeout(naive_datetime \\ NaiveDateTime.utc_now()) do
    NaiveDateTime.add(naive_datetime, @timeout_secs, :second)
  end

  def still_validate?(otp_timeout) do
    :lt == NaiveDateTime.compare(NaiveDateTime.utc_now(), otp_timeout)
  end

  def generate_receipt,
    do: (-1 * :erlang.monotonic_time()) |> Integer.to_string(32) |> String.replace("FVVV", "")

  def validate_otp(otp, valid_otp), do: {:sms, to_string(valid_otp) == to_string(otp)}
end
