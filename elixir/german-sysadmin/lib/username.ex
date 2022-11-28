defmodule Username do
  defp substitute(c) do
    case c do
      ?ä -> 'ae'
      ?ö -> 'oe'
      ?ü -> 'ue'
      ?ß -> 'ss'
      _ -> [c]
    end
  end

  @spec sanitize(charlist) :: charlist
  def sanitize(username) do
    username
    |> Enum.flat_map(&substitute/1)
    |> Enum.filter(&(&1 in ?a..?z || &1 == ?_))
  end
end
