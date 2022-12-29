defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.reduce(0, fn elem, acc ->
      if multiple?(elem, factors) do
        acc + elem
      else
        acc
      end
    end)
  end

  defp multiple?(_, []), do: false
  defp multiple?(number, [factor | _]) when rem(number, factor) == 0, do: true
  defp multiple?(number, [_ | factors]), do: multiple?(number, factors)
end
