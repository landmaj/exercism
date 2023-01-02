defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings = [first | _]) do
    ["And all for the want of a #{first}.\n" | for_want(strings)]
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  defp for_want(acc \\ [], strings)
  defp for_want(acc, [_a]), do: acc

  defp for_want(acc, [a, b | tail]) do
    ["For want of a #{a} the #{b} was lost." | acc] |> for_want([b | tail])
  end
end
