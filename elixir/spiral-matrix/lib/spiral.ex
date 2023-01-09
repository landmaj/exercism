defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(dimension :: integer) :: list(list(integer))
  def matrix(0), do: []

  def matrix(dimension) do
    iterate(dimension)
    |> Enum.with_index(fn {x, y}, i -> {y, x, i + 1} end)
    |> Enum.sort()
    |> Enum.map(fn {_, _, n} -> n end)
    |> Enum.chunk_every(dimension)
  end

  defp iterate(acc \\ [], dimension, point \\ {0, 0}, vector \\ {1, 0})

  defp iterate(acc, d, p, v) do
    acc = [p | acc]

    cond do
      move(p, v) |> valid?(d, acc) ->
        iterate(acc, d, move(p, v), v)

      turn_and_move(p, v) |> valid?(d, acc) ->
        iterate(acc, d, turn_and_move(p, v), turn(v))

      true ->
        Enum.reverse(acc)
    end
  end

  defp move({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

  defp turn_and_move(p, v), do: v |> turn() |> then(&move(p, &1))

  defp valid?({x, y}, d, _acc) when x < 0 or x >= d or y < 0 or y >= d, do: false
  defp valid?(point, _d, acc), do: point not in acc

  defp turn({1, 0}), do: {0, 1}
  defp turn({0, 1}), do: {-1, 0}
  defp turn({-1, 0}), do: {0, -1}
  defp turn({0, -1}), do: {1, 0}
end
