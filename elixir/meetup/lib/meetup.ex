defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @weekday %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}
  @start %{first: 1, second: 8, third: 15, fourth: 22, teenth: 13}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(
          pos_integer,
          pos_integer,
          Calendar.ISO.weekday(),
          schedule
        ) :: Date.t()
  def meetup(year, month, weekday, :last) do
    {:ok, date} = Date.new(year, month, 1)
    date |> Date.end_of_month() |> find_previus(weekday)
  end

  def meetup(year, month, weekday, schedule) do
    {:ok, date} = Date.new(year, month, @start[schedule])
    find_next(date, weekday)
  end

  defp find_next(start, weekday) do
    want = @weekday[weekday]

    case Date.day_of_week(start) do
      ^want -> start
      got when got > want -> Date.add(start, 7 - got + want)
      got -> Date.add(start, want - got)
    end
  end

  defp find_previus(start, weekday) do
    want = @weekday[weekday]

    case Date.day_of_week(start) do
      ^want -> start
      got when got > want -> Date.add(start, want - got)
      got -> Date.add(start, want - 7 - got)
    end
  end
end
