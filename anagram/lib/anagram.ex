defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&(not equal?(&1, base)))
    |> Enum.filter(&is_anagram?(&1, base))
  end

  defp is_anagram?(candidate, base) do
    same_characters?(candidate, base) and same_length?(candidate, base)
  end

  defp normalize(word), do: String.downcase(word) |> to_charlist()
  defp equal?(word1, word2), do: normalize(word1) == normalize(word2)
  defp same_characters?(word1, word2), do: normalize(word1) -- normalize(word2) == ''
  defp same_length?(word1, word2), do: length(normalize(word1)) == length(normalize(word2))
end
