defmodule Prime do
  @doc """
  Generates the nth prime.
  """

  @spec nth(non_neg_integer) :: non_neg_integer

  def nth(0), do: raise("there is no zeroth prime")

  def nth(count) do
    do_find_nth_prime(count)
  end

  defp do_find_nth_prime(count, factor \\ 3) do
    primes = generate_primes(count * factor)

    if length(primes) >= count do
      primes |> Enum.at(count - 1)
    else
      do_find_nth_prime(count, factor * 2)
    end
  end

  defp generate_primes(max) do
    do_generate_primes(0, 2..max |> Enum.to_list(), max)
  end

  defp do_generate_primes(index, list, max) do
    prime = Enum.at(list, index)

    if prime ** 2 > max do
      list
    else
      list = Enum.reject(list, fn x -> x != prime and rem(x, prime) == 0 end)

      do_generate_primes(index + 1, list, max)
    end
  end
end
