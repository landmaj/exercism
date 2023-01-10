defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, target) when target < 0, do: {:error, "cannot change"}

  def generate(coins, target) do
    case Map.get(do_generate(coins, target), target) do
      nil -> {:error, "cannot change"}
      change -> {:ok, change}
    end
  end

  defp do_generate(_, 0), do: %{0 => []}

  defp do_generate(coins, target) do
    acc = do_generate(coins, target - 1)

    coins
    |> Enum.map(fn c ->
      case Map.get(acc, target - c) do
        nil -> nil
        change -> [c | change]
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.min_by(&length/1, fn -> nil end)
    |> then(&Map.put(acc, target, &1))
  end
end
