defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([h | t]), do: chain?(t, h)
  def chain?([], {a, a}), do: true
  def chain?([], {_, _}), do: false

  def chain?(dominoes, {a, b}) do
    dominoes
    |> Stream.map(fn
      {^a, c} = match -> dominoes |> List.delete(match) |> chain?({b, c})
      {c, ^a} = match -> dominoes |> List.delete(match) |> chain?({b, c})
      _ -> false
    end)
    |> Enum.any?()
  end
end
