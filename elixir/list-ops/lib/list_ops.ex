defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(list), do: do_count(list)

  defp do_count(acc \\ 0, list)
  defp do_count(acc, []), do: acc
  defp do_count(acc, [_ | t]), do: do_count(acc + 1, t)

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list)

  defp do_reverse(acc \\ [], list)
  defp do_reverse(acc, []), do: acc
  defp do_reverse(acc, [h | t]), do: do_reverse([h | acc], t)

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, f)

  defp do_map(acc \\ [], list, func)
  defp do_map(acc, [], _), do: acc |> reverse()
  defp do_map(acc, [h | t], f), do: do_map([f.(h) | acc], t, f)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, f)

  defp do_filter(acc \\ [], list, func)
  defp do_filter(acc, [], _), do: acc |> reverse()

  defp do_filter(acc, [h | t], f) do
    if f.(h) do
      do_filter([h | acc], t, f)
    else
      do_filter(acc, t, f)
    end
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([], acc, _), do: acc
  def foldl([h | t], acc, f), do: foldl(t, f.(h, acc), f)

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f), do: l |> reverse() |> foldl(acc, f)

  @spec append(list, list) :: list
  def append(a, b), do: do_append(b, reverse(a))

  defp do_append(acc, []), do: acc
  defp do_append(acc, [h | t]), do: do_append([h | acc], t)

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h | t]), do: append(h, concat(t))
end
