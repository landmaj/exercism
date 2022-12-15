defmodule Raindrops do
  @factors [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}]

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number), do: do_convert(number)

  defp do_convert(number, factors \\ @factors, acc \\ "")

  defp do_convert(number, [], ""), do: to_string(number)
  defp do_convert(_number, [], acc), do: acc

  defp do_convert(number, [{factor, word} | tail], acc) when rem(number, factor) == 0 do
    do_convert(number, tail, acc <> word)
  end

  defp do_convert(number, [_factor | tail], acc), do: do_convert(number, tail, acc)
end
