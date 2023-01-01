defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(n) do
    1..n |> Enum.scan([], fn _, previous -> next_row(previous) end)
  end

  defp next_row([]), do: [1]

  defp next_row(row) do
    [0 | row]
    |> Enum.chunk_every(2, 1)
    |> Enum.map(&Enum.sum/1)
  end
end
