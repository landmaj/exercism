defmodule Gigasecond do
  @gigasecond 1.0e9 |> trunc()

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from(input) do
    input
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.add(@gigasecond)
    |> NaiveDateTime.to_erl()
  end
end
