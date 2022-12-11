defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    score = (:math.pow(x, 2) + :math.pow(y, 2)) |> :math.sqrt()

    cond do
      score <= 1 -> 10
      score <= 5 -> 5
      score <= 10 -> 1
      true -> 0
    end
  end
end
