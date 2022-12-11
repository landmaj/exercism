defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    Enum.filter(candidates, fn word -> anagram?(word, base) end)
  end

  defp sorted(word) do
    word
    |> String.to_charlist()
    |> Enum.sort()
  end

  defp anagram?(word, base) do
    word = String.downcase(word)
    base = String.downcase(base)
    word != base and sorted(word) == sorted(base)
  end
end
