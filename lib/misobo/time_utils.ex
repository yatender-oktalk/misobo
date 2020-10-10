defmodule Misobo.TimeUtils do
  @moduledoc """
  This module takes care of the time related functionlities
  """

  def utc_to_indian_timezone(naive_datetime_in_utc \\ DateTime.utc_now()),
    do: DateTime.add(naive_datetime_in_utc, 19_800)

  def get_day_of_week_today,
    do: utc_to_indian_timezone() |> DateTime.to_date() |> Date.day_of_week()
end
