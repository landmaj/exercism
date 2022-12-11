defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)
    power = length(digits)

    sum =
      Enum.reduce(digits, 0, fn d, acc ->
        acc + Integer.pow(d, power)
      end)

    number == sum
  end
end
