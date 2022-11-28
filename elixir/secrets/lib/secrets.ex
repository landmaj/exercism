defmodule Secrets do
  @spec secret_add(number) :: (number -> number)
  def secret_add(secret) do
    &(&1 + secret)
  end

  @spec secret_subtract(number) :: (number -> number)
  def secret_subtract(secret) do
    &(&1 - secret)
  end

  @spec secret_multiply(number) :: (number -> number)
  def secret_multiply(secret) do
    &(&1 * secret)
  end

  @spec secret_divide(number) :: (number -> float)
  def secret_divide(secret) do
    &(div(&1, secret))
  end

  @spec secret_and(integer) :: (integer -> integer)
  def secret_and(secret) do
    &(Bitwise.band(&1, secret))
  end

  @spec secret_xor(integer) :: (integer -> integer)
  def secret_xor(secret) do
    &(Bitwise.bxor(&1, secret))
  end

  @spec secret_combine((integer -> integer), (integer -> integer)) :: (integer -> integer)
  def secret_combine(secret_function1, secret_function2) do
    &(secret_function2.(secret_function1.(&1)))
  end
end
