defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.reduce(0, fn l, acc -> acc + score_letter(l) end)
  end

  defp score_letter(l) when l in ~w(a e i o u l n r s t), do: 1
  defp score_letter(l) when l in ~w(d g), do: 2
  defp score_letter(l) when l in ~w(b c m p), do: 3
  defp score_letter(l) when l in ~w(f h v w y), do: 4
  defp score_letter(l) when l in ~w(k), do: 5
  defp score_letter(l) when l in ~w(j x), do: 8
  defp score_letter(l) when l in ~w(q z), do: 10
  defp score_letter(_), do: 0
end
