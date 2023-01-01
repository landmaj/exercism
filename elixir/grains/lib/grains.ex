defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer()) :: {:ok, pos_integer()} | {:error, String.t()}
  def square(number) when number > 0 and number <= 64, do: {:ok, Integer.pow(2, number - 1)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer()}
  def total do
    total =
      1..64
      |> Enum.reduce(0, fn number, acc ->
        {_, v} = square(number)
        acc + v
      end)

    {:ok, total}
  end
end
