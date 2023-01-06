defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(1), do: 1

  def calculate(radicand) do
    radicand
    |> factors_for()
    |> Enum.take_every(2)
    |> Enum.product()
  end

  defp factors_for(number) do
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
