defmodule BeerSong do
  @first_part """
  __n__ __b__ of beer on the wall, __n__ __b__ of beer.
  """

  @second_part """
  Take __t__ down and pass it around, __n__ __b__ of beer on the wall.
  """

  @final_part """
  No more bottles of beer on the wall, no more bottles of beer.
  Go to the store and buy some more, 99 bottles of beer on the wall.
  """

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(0), do: @final_part

  def verse(number) do
    sing(@first_part, number) <> sing(@second_part, number - 1)
  end

  defp sing(verse, 0), do: replace(verse, "no more", "bottles", "it")
  defp sing(verse, 1), do: replace(verse, "1", "bottle")
  defp sing(verse, number), do: replace(verse, "#{number}", "bottles")

  defp replace(verse, n, b, t \\ "one") do
    verse
    |> String.replace("__n__", n)
    |> String.replace("__b__", b)
    |> String.replace("__t__", t)
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end
