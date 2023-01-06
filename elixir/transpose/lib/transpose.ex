defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples

    iex> Transpose.transpose("ABC\\nDE")
    "AD\\nBE\\nC"

    iex> Transpose.transpose("AB\\nDEF")
    "AD\\nBE\\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""

  def transpose(input) do
    rows = String.split(input, "\n")
    width = rows |> Enum.map(&String.length/1) |> Enum.max()

    rows
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&pad_trailing(&1, width))
    |> Enum.zip_with(& &1)
    |> Enum.map(&drop_trailing/1)
    |> Enum.map(&replace_nil/1)
    |> Enum.intersperse("\n")
    |> List.flatten()
    |> Enum.join()
  end

  defp pad_trailing(list, length) when length(list) >= length, do: list
  defp pad_trailing(list, length), do: list ++ List.duplicate(nil, length - length(list))

  defp drop_trailing(list) do
    count =
      list
      |> Enum.reverse()
      |> Enum.take_while(&is_nil/1)
      |> Enum.count()

    list |> Enum.drop(-count)
  end

  defp replace_nil(list) do
    list
    |> Enum.map(fn char -> if is_nil(char), do: " ", else: char end)
  end
end
