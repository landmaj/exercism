defmodule KitchenCalculator do
  @type unit :: :milliliter | :cup | :fluid_ounce | :teaspoon | :tablespoon

  @cup 240
  @fluid_ounce 30
  @teaspoon 5
  @tablespoon 15

  @spec get_volume({any, number}) :: number
  def get_volume({_, v}), do: v

  @spec to_milliliter({unit, number}) :: {:milliliter, number}
  def to_milliliter(v = {:milliliter, _}), do: v
  def to_milliliter({:cup, v}), do: {:milliliter, v * @cup}
  def to_milliliter({:fluid_ounce, v}), do: {:milliliter, v * @fluid_ounce}
  def to_milliliter({:teaspoon, v}), do: {:milliliter, v * @teaspoon}
  def to_milliliter({:tablespoon, v}), do: {:milliliter, v * @tablespoon}

  @spec from_milliliter({:milliliter, number}, unit) :: {unit, number}
  def from_milliliter(v = {:milliliter, _}, :milliliter), do: v
  def from_milliliter({:milliliter, v}, :cup), do: {:cup, v / @cup}
  def from_milliliter({:milliliter, v}, :fluid_ounce), do: {:fluid_ounce, v / @fluid_ounce}
  def from_milliliter({:milliliter, v}, :teaspoon), do: {:teaspoon, v / @teaspoon}
  def from_milliliter({:milliliter, v}, :tablespoon), do: {:tablespoon, v / @tablespoon}

  @spec convert({unit, number}, unit) :: {unit, number}
  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter
    |> from_milliliter(unit)
  end
end
