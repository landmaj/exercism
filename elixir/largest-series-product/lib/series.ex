defmodule Series do
  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(_, 0), do: 1
  def largest_product(_, size) when size < 0, do: raise(ArgumentError)

  def largest_product(number_string, size) do
    number_string
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> _largest_product(size)
  end

  defp _largest_product(digits, size) when size > length(digits), do: raise(ArgumentError)

  defp _largest_product(digits, size) do
    digits
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&Enum.reduce(&1, fn n, acc -> n * acc end))
    |> Enum.max()
  end
end
