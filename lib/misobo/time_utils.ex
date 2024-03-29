defmodule Misobo.TimeUtils do
  @moduledoc """
  This module takes care of the time related functionlities
  """

  @slot_duration Application.get_env(:misobo, :env)[:slot_duration]
  @start_time Application.get_env(:misobo, :env)[:start_time]
  @end_time Application.get_env(:misobo, :env)[:end_time]

  def utc_to_indian_timezone(naive_datetime_in_utc \\ DateTime.utc_now()),
    do: DateTime.add(naive_datetime_in_utc, 19_800)

  def get_day_of_week_today,
    do: utc_to_indian_timezone() |> DateTime.to_date() |> Date.day_of_week()

  def get_all_slots_for_day(date) do
    # let's say start time is 10 AM and end time is 6 PM
    # so last slot would be at 5:30 if we say 30 min slot each
    # we'll add the 600 minutes from the start of the day
    # {:ok, result} = Timex.parse("2016-12-29", "{YYYY}-{0M}-{D}")
    start_of_day = date |> Timex.beginning_of_day() |> Timex.to_unix()
    start_time = get_start_of_day_time(start_of_day)
    end_time = get_end_of_day_time(start_of_day)
    # so from start of the day we'll just take the slots in that duration
    # having the slot of 30 minutes each i.e. 1800 seconds
    get_slots(start_time, end_time)
  end

  def get_start_end_day(date) do
    {:ok, result} = Timex.parse(date, "{YYYY}-{0M}-{D}")
    start_of_day = result |> Timex.to_unix()
    start_time = get_start_of_day_time(start_of_day)
    end_time = get_end_of_day_time(start_of_day)

    {start_time, end_time}
  end

  defp get_start_of_day_time(start_of_day), do: String.to_integer(@start_time) + start_of_day
  defp get_end_of_day_time(start_of_day), do: String.to_integer(@end_time) + start_of_day

  defp get_slots(start_time, end_time) do
    all_slots(start_time, end_time)
    |> Enum.chunk_every(2, 1, :discard)
  end

  def all_slots(start_time, end_time) do
    start_time..end_time
    |> Enum.take_every(String.to_integer(@slot_duration))
  end

  def slot_filteration(date, available_time) do
    [start_time_expert, end_time_expert] =
      available_time
      |> String.split(",")
      |> Enum.map(fn time ->
        time |> String.trim() |> String.to_integer()
      end)

    {:ok, date} = date |> Timex.parse("{YYYY}-{0M}-{D}")
    date = date |> Timex.to_unix()
    {date + start_time_expert, date + end_time_expert}
  end

  def valid_date_format?(date) do
    case date |> Timex.parse("{YYYY}-{0M}-{D}") do
      {:ok, result} -> {true, result}
      _ -> {false, "invalid date format, please use 'YYYY-mm-dd' format"}
    end
  end

  def unix_to_date_time(unix_time), do: Timex.from_unix(unix_time)

  def start_time_today(date),
    do: date |> Timex.beginning_of_day() |> DateTime.add(-19800)

  def end_time_today(date), do: date |> Timex.end_of_day() |> DateTime.add(-19800)

  def get_unix_to_date_time(unix_time) do
    date_time = unix_time |> Timex.from_unix()
    date = date_time |> DateTime.to_date() |> to_string()
    {:ok, time} = date_time |> to_time()
    {date, time}
  end

  def get_day(date) do
    case date |> Timex.parse("{YYYY}-{0M}-{D}") do
      {:ok, result} ->
        result |> Timex.to_date() |> Date.day_of_week()

      _ ->
        []
    end
  end

  defp to_time(time) do
    Timex.format(time, "%I:%M%P", :strftime)
  end
end
