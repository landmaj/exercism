defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, fn {value, keys}, acc ->
      keys
      |> Enum.map(&String.downcase/1)
      |> Map.from_keys(value)
      |> Map.merge(acc)
    end)
  end
end
