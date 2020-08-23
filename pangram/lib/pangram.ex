defmodule Pangram do
  @alphabet ?a..?z |> Enum.to_list()

  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    used_letters =
      sentence
      |> String.downcase()
      |> to_charlist()

    Enum.all?(@alphabet, &(&1 in used_letters))
  end
end
