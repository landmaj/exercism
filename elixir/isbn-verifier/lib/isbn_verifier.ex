defmodule IsbnVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    normalized = isbn |> String.replace("-", "")

    if valid?(normalized) do
      normalized
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {element, index} ->
        number = if element == "X", do: 10, else: String.to_integer(element)
        number * (10 - index)
      end)
      |> Enum.sum()
      |> Integer.mod(11)
      |> then(&(&1 == 0))
    else
      false
    end
  end

  defp valid?(isbn), do: isbn |> String.match?(~r/^\d{9}[X|\d]$/)
end
