defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0, do: {:error, "number is out of range"}
  def in_english(number) when number >= 1_000_000_000_000, do: {:error, "number is out of range"}

  def in_english(number) do
    digits =
      number
      |> Integer.digits()
      |> Enum.reverse()
      |> Enum.chunk_every(3)
      |> Enum.map(&Enum.reverse/1)
      |> Enum.reverse()

    spelled_out =
      digits
      |> to_word()
      |> String.trim()

    {:ok, spelled_out}
  end

  defp to_word([[0]]), do: "zero"
  defp to_word([[0, 0, 0]]), do: ""
  defp to_word([[0 | rest]]), do: to_word([rest])
  defp to_word([[0, 0, 0] | rest]), do: to_word(rest)

  defp to_word([[1]]), do: "one"
  defp to_word([[2]]), do: "two"
  defp to_word([[3]]), do: "three"
  defp to_word([[4]]), do: "four"
  defp to_word([[5]]), do: "five"
  defp to_word([[6]]), do: "six"
  defp to_word([[7]]), do: "seven"
  defp to_word([[8]]), do: "eight"
  defp to_word([[9]]), do: "nine"

  defp to_word([[1, 0]]), do: "ten"
  defp to_word([[1, 1]]), do: "eleven"
  defp to_word([[1, 2]]), do: "twelve"
  defp to_word([[1, 3]]), do: "thirteen"
  defp to_word([[1, 5]]), do: "fifteen"
  defp to_word([[1, ones]]), do: "#{to_word([[ones]])}teen"

  defp to_word([[2, 0]]), do: "twenty"
  defp to_word([[3, 0]]), do: "thirty"
  defp to_word([[4, 0]]), do: "forty"
  defp to_word([[5, 0]]), do: "fifty"
  defp to_word([[8, 0]]), do: "eighty"
  defp to_word([[tens, 0]]), do: "#{to_word([[tens]])}ty"
  defp to_word([[tens, ones]]), do: "#{to_word([[tens, 0]])}-#{to_word([[ones]])}"

  defp to_word([[hundreds, 0, 0]]), do: "#{to_word([[hundreds]])} hundred"
  defp to_word([[hundreds | rest]]), do: "#{to_word([[hundreds, 0, 0]])} #{to_word([rest])}"

  @group_names %{
    1 => "thousand",
    2 => "million",
    3 => "billion"
  }

  defp to_word([group | rest]) do
    group_name = rest |> length() |> then(&Map.get(@group_names, &1))
    "#{to_word([group])} #{group_name} #{to_word(rest)}"
  end
end
