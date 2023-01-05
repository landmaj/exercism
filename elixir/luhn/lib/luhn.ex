defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    with cleaned <- String.replace(number, " ", ""),
         true <- String.match?(cleaned, ~r/^\d+$/),
         digits <- cleaned |> String.graphemes() |> Enum.map(&String.to_integer/1),
         true <- luhn?(digits) do
      true
    end
  end

  defp luhn?([0]), do: false

  defp luhn?(digits) do
    digits
    |> Enum.reverse()
    |> Enum.chunk_every(2)
    |> Enum.map(fn
      [first, second] -> [first, second * 2]
      [first | []] -> [first]
    end)
    |> List.flatten()
    |> Enum.map(&if &1 > 9, do: &1 - 9, else: &1)
    |> Enum.sum()
    |> then(&(rem(&1, 10) == 0))
  end
end
