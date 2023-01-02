defmodule ResistorColorTrio do
  @mapping %{
    :black => 0,
    :brown => 1,
    :red => 2,
    :orange => 3,
    :yellow => 4,
    :green => 5,
    :blue => 6,
    :violet => 7,
    :grey => 8,
    :white => 9
  }

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([tens, ones, zeros]) do
    (@mapping[tens] * 10 + @mapping[ones])
    |> Kernel.*(Integer.pow(10, @mapping[zeros]))
    |> normalize()
  end

  defp normalize(number) when number > 1000, do: {div(number, 1000), :kiloohms}
  defp normalize(number), do: {number, :ohms}
end
