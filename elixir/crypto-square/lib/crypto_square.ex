defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(str) do
    normalized = str |> normalize()
    columns = normalized |> columns()

    normalized
    |> String.graphemes()
    |> Enum.chunk_every(columns, columns, Stream.cycle([' ']))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.join(" ")
  end

  defp normalize(str) do
    str
    |> String.replace(~r/[^\w]/, "")
    |> String.downcase()
  end

  defp columns(str) do
    str
    |> String.length()
    |> :math.sqrt()
    |> ceil()
  end
end
