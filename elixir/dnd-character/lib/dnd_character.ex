defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    score
    |> Kernel.-(10)
    |> Kernel./(2)
    |> Float.floor()
    |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    for(_ <- 1..4, do: :rand.uniform(6))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    stats = %__MODULE__{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }

    %{stats | hitpoints: 10 + modifier(stats.constitution)}
  end
end
