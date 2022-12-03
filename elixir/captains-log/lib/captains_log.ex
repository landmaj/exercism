defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  @spec random_planet_class() :: String.t()
  def random_planet_class(), do: Enum.random(@planetary_classes)

  @spec random_ship_registry_number() :: String.t()
  def random_ship_registry_number() do
    no = Enum.random(1000..9999)
    "NCC-#{no}"
  end

  @spec random_stardate() :: float
  def random_stardate() do
    41000.0 + :rand.uniform() * 1000.0
  end

  @spec format_stardate(float) :: String.t()
  def format_stardate(stardate) do
    :io_lib.format("~.1f", [stardate]) |> List.to_string()
  end
end
