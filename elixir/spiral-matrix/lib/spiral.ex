defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(dimension) do
    next_row([], (dimension ** 2)..1 |> Enum.to_list())
  end

  defp next_row(acc, []), do: acc

  defp next_row(acc, nums) do
    acc = acc |> transpose() |> rotate()
    width = Enum.at(acc, 0, [nil]) |> length()
    row = Enum.take(nums, width) |> Enum.reverse()
    next_row([row | acc], Enum.drop(nums, width))
  end

  defp transpose(list), do: Enum.zip_with(list, & &1)
  defp rotate(list), do: Enum.map(list, &Enum.reverse/1)
end
