defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.graphemes()
    |> do_encode()
    |> Enum.join()
  end

  defp do_encode(input, acc \\ [])
  defp do_encode([], acc), do: Enum.reverse(acc)

  defp do_encode(input = [char | _], acc) do
    consecutive = Enum.take_while(input, &(&1 == char)) |> Enum.count()
    rest = Enum.drop(input, consecutive)

    if consecutive == 1 do
      do_encode(rest, [char | acc])
    else
      do_encode(rest, [char, to_string(consecutive) | acc])
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> to_charlist()
    |> do_decode()
    |> to_string()
  end

  defp do_decode(input, acc \\ [])
  defp do_decode([], acc), do: Enum.reverse(acc)

  defp do_decode(input, acc) do
    digits = Enum.take_while(input, fn c -> c in ?0..?9 end)

    if length(digits) == 0 do
      [char | tail] = input
      do_decode(tail, [char | acc])
    else
      count = digits |> to_string() |> String.to_integer()
      char = input |> Enum.drop(length(digits)) |> List.first()
      chars = String.duplicate(<<char::utf8>>, count)
      do_decode(Enum.drop(input, length(digits) + 1), [chars | acc])
    end
  end
end
