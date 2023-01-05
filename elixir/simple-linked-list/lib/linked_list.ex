defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Counts the number of elements in a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: do_count(list)

  defp do_count(acc \\ 0, list)
  defp do_count(acc, {}), do: acc
  defp do_count(acc, {_, next}), do: do_count(acc + 1, next)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({}), do: {:error, :empty_list}
  def peek({head, _}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({}), do: {:error, :empty_list}
  def tail({_, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({}), do: {:error, :empty_list}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list), do: do_from_list(list) |> reverse()

  defp do_from_list(acc \\ new(), list)
  defp do_from_list(acc, []), do: acc
  defp do_from_list(acc, [head | tail]), do: acc |> push(head) |> do_from_list(tail)

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list), do: list |> reverse() |> do_to_list()

  defp do_to_list(acc \\ [], list)
  defp do_to_list(acc, {}), do: acc
  defp do_to_list(acc, {head, tail}), do: [head | acc] |> do_to_list(tail)

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list)

  defp do_reverse(acc \\ new(), list)
  defp do_reverse(acc, {}), do: acc
  defp do_reverse(acc, {head, tail}), do: acc |> push(head) |> do_reverse(tail)
end
