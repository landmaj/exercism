defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> to_charlist()
    |> Enum.flat_map(&convert_char/1)
    |> Enum.chunk_every(5)
    |> Enum.intersperse(" ")
    |> List.flatten()
    |> to_string()
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> to_charlist()
    |> Enum.flat_map(&convert_char/1)
    |> to_string()
  end

  defp convert_char(char) when char in ?1..?9, do: [char]
  defp convert_char(char) when char in ?a..?z, do: [?z - char + ?a]
  defp convert_char(char) when char in ?A..?Z, do: convert_char(char + ?a - ?A)
  defp convert_char(_), do: []
end
