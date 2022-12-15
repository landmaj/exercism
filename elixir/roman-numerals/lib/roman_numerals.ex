defmodule RomanNumerals do
  @conversion_chart %{
    3000 => "MMM",
    2000 => "MM",
    1000 => "M",
    900 => "CM",
    800 => "DCCC",
    700 => "DCC",
    600 => "DC",
    500 => "D",
    400 => "CD",
    300 => "CCC",
    200 => "CC",
    100 => "C",
    90 => "XC",
    80 => "LXXX",
    70 => "LXX",
    60 => "LX",
    50 => "L",
    40 => "XL",
    30 => "XXX",
    20 => "XX",
    10 => "X",
    9 => "IX",
    8 => "VIII",
    7 => "VII",
    6 => "VI",
    5 => "V",
    4 => "IV",
    3 => "III",
    2 => "II",
    1 => "I"
  }

  @length_to_factor %{
    1 => 1,
    2 => 10,
    3 => 100,
    4 => 1000
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> Integer.digits()
    |> convert()
  end

  defp convert(digits, acc \\ [])
  defp convert([], acc), do: acc |> Enum.join()

  defp convert(digits = [d | tail], acc) do
    value = d * @length_to_factor[length(digits)]
    convert(tail, acc ++ [@conversion_chart[value]])
  end
end
