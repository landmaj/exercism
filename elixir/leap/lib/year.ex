defmodule Year do
  defguardp divisible_by_4(year) when rem(year, 4) == 0
  defguardp divisible_by_100(year) when rem(year, 100) == 0
  defguardp divisible_by_400(year) when rem(year, 400) == 0

  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) when divisible_by_400(year), do: true
  def leap_year?(year) when divisible_by_100(year), do: false
  def leap_year?(year) when divisible_by_4(year), do: true
  def leap_year?(_), do: false
end
