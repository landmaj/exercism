defmodule Sieve do
  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit), do: _primes_to(Enum.to_list(2..limit), limit, [])

  defp _primes_to([], _, acc), do: acc |> Enum.reverse()

  defp _primes_to([next | rest], limit, acc) do
    next..limit//next
    |> Enum.to_list()
    |> then(&(rest -- &1))
    |> then(&_primes_to(&1, limit, [next | acc]))
  end
end
