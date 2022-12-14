defmodule PigLatin do
  # y is omitted on purpose
  @vowels [?a, ?e, ?i, ?o, ?u]
  @consonants Enum.to_list(?a..?z) -- @vowels

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split()
    |> Enum.map(&transform/1)
    |> Enum.join(" ")
  end

  defp transform(word) do
    word
    |> to_charlist()
    |> do_transform()
    |> then(fn word -> word ++ [?a, ?y] end)
    |> to_string()
  end

  defp do_transform([?q, ?u | t]), do: t ++ [?q, ?u]
  defp do_transform(word = [?x, l | _]) when l in @consonants, do: word
  defp do_transform(word = [?y, l | _]) when l in @consonants, do: word
  defp do_transform(word = [h | _]) when h in @vowels, do: word
  defp do_transform([h | t]), do: do_transform(t ++ [h])
end
