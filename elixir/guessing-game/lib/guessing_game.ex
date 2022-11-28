defmodule GuessingGame do
  @spec compare(integer, integer | :no_guess ) :: String.t()
  def compare(a, b \\ :no_guess)
  def compare(_, :no_guess), do: "Make a guess"
  def compare(a, a), do: "Correct"
  def compare(a, b) when abs(a - b) == 1, do: "So close"
  def compare(a, b) when b > a, do: "Too high"
  def compare(a, b) when b < a, do: "Too low"
end
