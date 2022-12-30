defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    new_number = if number == 0, do: 99, else: number - 1

    [
      bottle_verse(number) |> String.capitalize(),
      " on the wall, ",
      bottle_verse(number),
      ".\n",
      action_verse(number) |> String.capitalize(),
      ", ",
      bottle_verse(new_number),
      " on the wall.\n"
    ]
    |> Enum.join()
  end

  defp bottle_verse(0), do: "no more bottles of beer"
  defp bottle_verse(1), do: "1 bottle of beer"
  defp bottle_verse(n), do: "#{n} bottles of beer"

  defp action_verse(0), do: "go to the store and buy some more"
  defp action_verse(1), do: "take it down and pass it around"
  defp action_verse(_), do: "take one down and pass it around"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0)
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
