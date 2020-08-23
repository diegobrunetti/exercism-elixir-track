defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> to_charlist()
    |> Enum.map(&get_value/1)
    |> Enum.sum()
  end

  defp get_value(char) do
    cond do
      char in 'AEIOULNRST' -> 1
      char in 'DG' -> 2
      char in 'BCMP' -> 3
      char in 'FHVWY' -> 4
      char in 'K' -> 5
      char in 'JX' -> 8
      char in 'QZ' -> 10
      char in ' \n\t' -> 0
    end
  end
end
