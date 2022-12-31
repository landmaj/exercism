defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    silence = silence?(input)
    input |> parse(silence) |> response()
  end

  @types [
    {~r/^\p{Lu}+\?$/, {:yell, :question}},
    {~r/^\p{Lu}+$/, :yell},
    {~r/^.*\?$/, :question}
  ]

  defp silence?(input), do: input =~ ~r/^\s*$/

  defp parse(_, true), do: :silence

  defp parse(input, false) do
    processed = String.replace(input, ~r/[^\p{L}?]/, "")

    with {_, type} <- Enum.find(@types, fn {rx, _} -> String.match?(processed, rx) end) do
      type
    else
      nil -> nil
    end
  end

  defp response({:yell, :question}), do: "Calm down, I know what I'm doing!"
  defp response(:yell), do: "Whoa, chill out!"
  defp response(:question), do: "Sure."
  defp response(:silence), do: "Fine. Be that way!"
  defp response(_), do: "Whatever."
end
