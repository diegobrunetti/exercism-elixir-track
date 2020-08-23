defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.split(~r/[^[:alnum:]-]/u, trim: true)
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(%{}, &increment/2)
  end

  defp increment(word, map), do: Map.update(map, word, 1, &(&1 + 1))
end
