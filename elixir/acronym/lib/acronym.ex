defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.replace(~r/[_]/, "")
    |> String.split(~r/[\s-]+/)
    |> Enum.map(&String.first/1)
    |> Enum.map(&String.upcase/1)
    |> to_string()
  end
end
