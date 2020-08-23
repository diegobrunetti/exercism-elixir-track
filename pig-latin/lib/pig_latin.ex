defmodule PigLatin do
  @not_vowel_sound ~r/^([xy](?=[aeiou]))|^[^aeiouyx]*(qu)|^([^aeiouyx]+)/

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&to_pig/1)
    |> Enum.join(" ")
  end

  defp to_pig(word) do
    consonants = consonants_at_the_start(word)
    String.replace_prefix(word, consonants, "") <> consonants <> "ay"
  end

  defp consonants_at_the_start(phrase) do
    case Regex.run(@not_vowel_sound, phrase) do
      nil -> ""
      value -> hd(value)
    end
  end
end
