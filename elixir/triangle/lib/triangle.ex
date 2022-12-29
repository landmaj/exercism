defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguard is_non_positive(a, b, c) when a <= 0 or b <= 0 or c <= 0
  defguard violates_inequality(a, b, c) when a + b < c or a + c < b or b + c < a

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when is_non_positive(a, b, c), do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when violates_inequality(a, b, c), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c), do: {:ok, determine_kind(a, b, c)}

  defp determine_kind(a, a, a), do: :equilateral
  defp determine_kind(a, a, _), do: :isosceles
  defp determine_kind(a, _, a), do: :isosceles
  defp determine_kind(_, a, a), do: :isosceles
  defp determine_kind(_, _, _), do: :scalene
end
