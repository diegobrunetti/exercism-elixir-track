defmodule DndCharacter do
  @hp_base 10

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
    cond do
      score > @hp_base -> calc_modifier(score) |> trunc
      true -> calc_modifier(score) |> round
    end
  end

  defp calc_modifier(score), do: (score - @hp_base) / 2

  @spec ability :: pos_integer()
  def ability do
    for(_times <- 1..4, do: Enum.random(1..6))
    |> tl
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    character = %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: ability(),
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability()
    }

    %{character | hitpoints: 10 + modifier(character.constitution)}
  end
end
