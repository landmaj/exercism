defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    normalized =
      sentence
      |> String.replace(~r/[-\s]/, "")
      |> String.downcase()
      |> String.graphemes()

    normalized == Enum.uniq(normalized)
  end
end
