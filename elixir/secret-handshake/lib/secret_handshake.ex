defmodule SecretHandshake do
  import Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> wink?(code)
    |> double_blink?(code)
    |> close_your_eyes?(code)
    |> jump?(code)
    |> reverse?(code)
  end

  defp wink?(acc, code) when (code &&& 1) == 1, do: acc ++ ["wink"]
  defp wink?(acc, _code), do: acc

  defp double_blink?(acc, code) when (code >>> 1 &&& 1) == 1, do: acc ++ ["double blink"]
  defp double_blink?(acc, _code), do: acc

  defp close_your_eyes?(acc, code) when (code >>> 2 &&& 1) == 1, do: acc ++ ["close your eyes"]
  defp close_your_eyes?(acc, _code), do: acc

  defp jump?(acc, code) when (code >>> 3 &&& 1) == 1, do: acc ++ ["jump"]
  defp jump?(acc, _code), do: acc

  defp reverse?(acc, code) when (code >>> 4 &&& 1) == 1, do: Enum.reverse(acc)
  defp reverse?(acc, _code), do: acc
end
