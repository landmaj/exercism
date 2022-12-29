defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) do
    cond do
      sublist?(b, a) -> :sublist
      sublist?(a, b) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?(_, []), do: true
  defp sublist?([], _), do: false
  defp sublist?(list = [_ | tail], sublist) do
    List.starts_with?(list, sublist) or sublist?(tail, sublist)
  end
end
