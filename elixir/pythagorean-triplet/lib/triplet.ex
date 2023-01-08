defmodule Triplet do
  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  defdelegate sum(triplet), to: Enum

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  defdelegate product(triplet), to: Enum

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]) do
    a ** 2 + b ** 2 == c ** 2
  end

  @doc """
  Generates a list of pythagorean triplets whose values add up to a given sum.
  """
  @spec generate(non_neg_integer) :: [list(non_neg_integer)]
  def generate(sum) do
    max_a = div(sum, 3) - 1
    min_c = max_a + 2

    for a <- 1..max_a,
        c <- min_c..(sum - 2 * a - 1),
        b = sum - a - c,
        a < b and b < c,
        pythagorean?([a, b, c]) do
      [a, b, c]
    end
  end
end
