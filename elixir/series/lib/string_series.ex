defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    s
    |> String.graphemes()
    |> Enum.chunk_while([], &chunk(&2, &1, size), &final_chunk(&1, size))
    |> List.flatten()
  end

  defp chunk(acc = [_ | tail], elem, size) when length(acc) == size do
    {:cont, Enum.join(acc), tail ++ [elem]}
  end

  defp chunk(acc, elem, _size), do: {:cont, acc ++ [elem]}

  defp final_chunk(acc, size) when length(acc) == size do
    {:cont, Enum.join(acc), acc}
  end

  defp final_chunk(acc, _size), do: {:cont, acc}
end
