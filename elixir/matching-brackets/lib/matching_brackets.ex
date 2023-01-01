defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @non_brackets ~r/[^\(\)\[\]\{\}]/
  @matching_pattern ~r/(\(\)|\[\]|\{\})/

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(@non_brackets, "")
    |> reduce()
    |> then(&(&1 == ""))
  end

  defp reduce(input) do
    output = String.replace(input, @matching_pattern, "")

    if input == output do
      output
    else
      reduce(output)
    end
  end
end
