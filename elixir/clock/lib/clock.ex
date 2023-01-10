defmodule Clock do
  @type t :: %__MODULE__{
          hour: integer(),
          minute: integer()
        }

  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: __MODULE__.t()
  def new(hour, minute) do
    {minute, overflow} = do_minute(minute)
    hour = do_hour(hour + overflow)
    %__MODULE__{hour: hour, minute: minute}
  end

  defp do_hour(h) when h < 0, do: do_hour(24 + h)
  defp do_hour(h), do: rem(h, 24)

  defp do_minute(m, o \\ 0)
  defp do_minute(m, o) when m < 0, do: do_minute(m + 60, o - 1)
  defp do_minute(m, o), do: {rem(m, 60), o + div(m, 60)}

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(__MODULE__.t(), integer) :: __MODULE__.t()
  def add(%__MODULE__{hour: hour, minute: minute}, add_minute) do
    new(hour, minute + add_minute)
  end
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: hour, minute: minute}) do
    hour = hour |> Integer.to_string() |> String.pad_leading(2, "0")
    minute = minute |> Integer.to_string() |> String.pad_leading(2, "0")
    "#{hour}:#{minute}"
  end
end
