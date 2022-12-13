defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @alphabet Enum.to_list(?a..?z)

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(fn char -> char in ?a..?z end)
    |> Enum.sort()
    |> Enum.dedup()
    |> then(&(&1 == @alphabet))
  end
end
