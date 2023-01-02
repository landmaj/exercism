defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    do_factors_for(number, 2, [])
  end

  defp do_factors_for(1, _, acc), do: acc |> Enum.reverse()

  defp do_factors_for(number, factor, acc) when rem(number, factor) == 0 do
    do_factors_for(div(number, factor), factor, [factor | acc])
  end

  defp do_factors_for(number, 2, acc) do
    do_factors_for(number, 3, acc)
  end

  defp do_factors_for(number, factor, acc) do
    do_factors_for(number, factor + 2, acc)
  end
end
