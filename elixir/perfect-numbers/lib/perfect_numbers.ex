defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number <= 0,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(1), do: {:ok, :deficient}

  def classify(number) do
    aliquot =
      for a <- 1..(:math.sqrt(number) |> trunc()), rem(number, a) == 0 do
        case (number / a) |> trunc() do
          ^a -> [a]
          ^number -> [a]
          b -> [a, b]
        end
      end
      |> List.flatten()
      |> Enum.sum()

    cond do
      aliquot == number -> {:ok, :perfect}
      aliquot > number -> {:ok, :abundant}
      aliquot < number -> {:ok, :deficient}
    end
  end
end
