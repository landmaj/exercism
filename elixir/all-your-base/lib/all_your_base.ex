defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}

  def convert(digits, input_base, output_base) do
    if valid_digits?(digits, input_base) do
      digits
      |> convert_to_decimal(input_base)
      |> convert_from_decimal(output_base)
      |> then(fn v -> {:ok, v} end)
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end

  defp valid_digits?(digits, base) do
    digits |> Enum.all?(fn x -> x >= 0 and x < base end)
  end

  defp convert_to_decimal(input, base) do
    input
    |> Enum.reverse()
    |> Stream.with_index()
    |> Enum.reduce(0, fn {number, index}, acc ->
      (number * :math.pow(base, index) + acc) |> trunc
    end)
  end

  defp convert_from_decimal(input, base), do: do_convert_from_decimal(input, base, [])

  defp do_convert_from_decimal(input, base, acc) when input < base, do: [input | acc]

  defp do_convert_from_decimal(input, base, acc) do
    do_convert_from_decimal(div(input, base), base, [rem(input, base) | acc])
  end
end
