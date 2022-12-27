defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: do_keep(list, fun)

  defp do_keep(acc \\ [], list, fun)
  defp do_keep(acc, [], _fun), do: Enum.reverse(acc)
  defp do_keep(acc, [head | tail], fun) do
    if fun.(head) do
      do_keep([head | acc], tail, fun)
    else
      do_keep(acc, tail, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: do_discard(list, fun)

  defp do_discard(acc \\ [], list, fun)
  defp do_discard(acc, [], _fun), do: Enum.reverse(acc)
  defp do_discard(acc, [head | tail], fun) do
    if not fun.(head) do
      do_discard([head | acc], tail, fun)
    else
      do_discard(acc, tail, fun)
    end
  end
end
