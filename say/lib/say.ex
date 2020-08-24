defmodule Say do
  @max 999_999_999_999

  @scales %{
    1_000_000_000 => "billion",
    1_000_000 => "million",
    1_000 => "thousand",
    100 => "hundred",
    90 => "ninety",
    80 => "eighty",
    70 => "seventy",
    60 => "sixty",
    50 => "fifty",
    40 => "forty",
    30 => "thirty",
    20 => "twenty",
    19 => "nineteen",
    18 => "eighteen",
    17 => "seventeen",
    16 => "sixteen",
    15 => "fifteen",
    14 => "fourteen",
    13 => "thirteen",
    12 => "twelve",
    11 => "eleven",
    10 => "ten",
    9 => "nine",
    8 => "eight",
    7 => "seven",
    6 => "six",
    5 => "five",
    4 => "four",
    3 => "three",
    2 => "two",
    1 => "one",
    0 => "zero"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < 0, do: error()
  def in_english(number), do: chunks(number, []) |> speak()

  defp chunks(number, _) when number > @max, do: []
  defp chunks(0, []), do: [{0, 0}]
  defp chunks(0, acc), do: acc

  defp chunks(number, acc) do
    scale =
      Map.keys(@scales)
      |> Enum.reverse()
      |> Enum.find(fn n -> n <= number end)

    units = floor(number / scale)
    remainder = rem(number, scale)
    chunks(remainder, acc ++ [{units, scale}])
  end

  defp speak([]), do: error()

  defp speak(chunks) do
    translated = chunks |> Enum.reduce("", fn chunk, acc -> to_english(chunk, acc) end)
    {:ok, translated}
  end

  defp to_english({_, scale}, "") when scale <= 20, do: @scales[scale]
  defp to_english({_, scale}, acc) when scale < 20, do: acc <> "-#{@scales[scale]}"
  defp to_english({_, scale}, acc) when scale in 20..90, do: append(@scales[scale], acc)

  defp to_english({units, scale}, acc) do
    {:ok, prefix} = in_english(units)
    append("#{prefix} #{@scales[scale]}", acc)
  end

  defp append(string, ""), do: string
  defp append(string, acc), do: acc <> " #{string}"

  defp error(), do: {:error, "number is out of range"}
end
