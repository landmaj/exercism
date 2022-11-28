defmodule HighScore do
  @initial_score 0

  @spec new :: map
  def new(), do: %{}

  @spec add_player(map, String.t, integer) :: map
  def add_player(scores, name, score \\ @initial_score)
  def add_player(scores, name, score), do: Map.put(scores, name, score)

  @spec remove_player(map, String.t) :: map
  def remove_player(scores, name), do: Map.delete(scores, name)

  @spec reset_score(map, String.t) :: map
  def reset_score(scores, name), do: Map.put(scores, name, @initial_score)

  @spec update_score(map, String.t, integer) :: map
  def update_score(scores, name, score), do: Map.update(scores, name, score, &(&1 + score))

  @spec get_players(map) :: list(String.t)
  def get_players(scores), do: Map.keys(scores)
end
