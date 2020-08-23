defmodule ResistorColor do
  @colors [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
  ]
  @moduledoc false

  @spec colors() :: list(String.t())
  def colors do
    @colors
  end

  @spec code(String.t()) :: integer()
  def code(color) do
    Enum.find_index(@colors, fn c -> c == color end)
  end
end
