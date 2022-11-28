defmodule BirdCount do
  @spec today(list(integer)) :: integer | nil
  def today([]), do: nil
  def today([head | _]), do: head

  @spec increment_day_count(list(integer)) :: list(integer)
  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  @spec has_day_without_birds?(list(integer)) :: boolean
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | tail]), do: has_day_without_birds?(tail)

  @spec total(list(integer)) :: integer
  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  @spec busy_days(list(integer)) :: integer
  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5, do: 1 + busy_days(tail)
  def busy_days([_ | tail]), do: busy_days(tail)
end
