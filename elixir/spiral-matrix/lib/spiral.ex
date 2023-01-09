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

  defp iterate(d) do
    iterate([], d ** 2, {-1, 0}, nil, {-1, 0}, {d - 1, 0}, {d - 1, d - 1}, {0, d - 1})
  end

  defp iterate(acc, 0, _, _, _, _, _, _) do
    acc |> Enum.reverse()
  end

  defp iterate(acc, c, p = {x, y}, _d, tl, tr, br, bl) when p == tl do
    np = {x + 1, y}
    iterate([np | acc], c - 1, np, {1, 0}, {x + 1, y + 1}, tr, br, bl)
  end

  defp iterate(acc, c, p = {x, y}, _d, tl, tr, br, bl) when p == tr do
    np = {x, y + 1}
    iterate([np | acc], c - 1, np, {0, 1}, tl, {x - 1, y + 1}, br, bl)
  end

  defp iterate(acc, c, p = {x, y}, _d, tl, tr, br, bl) when p == br do
    np = {x - 1, y}
    iterate([np | acc], c - 1, np, {-1, 0}, tl, tr, {x - 1, y - 1}, bl)
  end

  defp iterate(acc, c, p = {x, y}, _d, tl, tr, br, bl) when p == bl do
    np = {x, y - 1}
    iterate([np | acc], c - 1, np, {0, -1}, tl, tr, br, {x + 1, y - 1})
  end

  defp iterate(acc, c, {x, y}, d = {dx, dy}, tl, tr, br, bl) do
    np = {x + dx, y + dy}
    iterate([np | acc], c - 1, np, d, tl, tr, br, bl)
  end
end
