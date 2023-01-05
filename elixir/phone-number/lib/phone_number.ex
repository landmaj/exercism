defmodule PhoneNumber do
  @doc """
  Remove formatting from a phone number if the given number is valid. Return an error otherwise.
  """
  @spec clean(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def clean(raw) do
    with cleaned <- String.replace(raw, ~r/[\(\)\+\-\.\s]/, ""),
         true <- digits?(cleaned),
         true <- valid?(cleaned) do
      {:ok, cleaned |> String.trim_leading("1")}
    end
  end

  defp digits?(str) when is_binary(str) do
    str |> to_charlist() |> Enum.all?(&(&1 in ?0..?9)) |> digits?()
  end

  defp digits?(true), do: true
  defp digits?(false), do: {:error, "must contain digits only"}

  defp valid?(str) when is_binary(str),
    do: str |> String.graphemes() |> Enum.map(&String.to_integer/1) |> valid?()

  defp valid?(digits) when length(digits) < 10, do: {:error, "incorrect number of digits"}
  defp valid?(digits) when length(digits) > 11, do: {:error, "incorrect number of digits"}

  defp valid?(digits = [first | _]) when length(digits) == 11 and first != 1,
    do: {:error, "11 digits must start with 1"}

  defp valid?([_ | digits]) when length(digits) == 10, do: valid?(digits)

  defp valid?([0 | _]), do: {:error, "area code cannot start with zero"}
  defp valid?([1 | _]), do: {:error, "area code cannot start with one"}

  defp valid?([_, _, _, 0 | _]), do: {:error, "exchange code cannot start with zero"}
  defp valid?([_, _, _, 1 | _]), do: {:error, "exchange code cannot start with one"}

  defp valid?(_), do: true
end
