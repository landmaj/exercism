defmodule LibraryFees do
  @before_noon_days 28
  @after_noon_days 29

  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  @spec before_noon?(NaiveDateTime.t()) :: boolean
  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.compare(~T[12:00:00])
    |> then(&(&1 == :lt))
  end

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_datetime) do
    days =
      if before_noon?(checkout_datetime) do
        @before_noon_days
      else
        @after_noon_days
      end

    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(days)
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: integer
  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> then(&if &1 > 0, do: &1, else: 0)
  end

  @spec monday?(NaiveDateTime.t()) :: boolean
  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week()
    |> then(&(&1 == 1))
  end

  @spec calculate_late_fee(String.t(), String.t(), integer) :: integer
  def calculate_late_fee(checkout, return, rate) do
    planned_return_date =
      checkout
      |> datetime_from_string()
      |> return_date()

    return_date = return |> datetime_from_string()
    days_late = return_date |> then(&days_late(planned_return_date, &1))

    do_calculate_late_fee(days_late, rate, monday?(return_date))
  end

  @spec do_calculate_late_fee(
          days_late :: integer,
          rate :: integer,
          monday? :: boolean
        ) :: integer
  defp do_calculate_late_fee(days_late, rate, false), do: days_late * rate

  defp do_calculate_late_fee(days_late, rate, true) do
    days_late
    |> Kernel.*(rate)
    |> Kernel.*(0.5)
    |> Float.floor()
    |> trunc()
  end
end
