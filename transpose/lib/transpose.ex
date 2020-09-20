defmodule Transpose do
  import Kernel, except: [to_string: 1]

  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> String.split("\n")
    |> normalize()
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> to_string()
    |> Enum.join("\n")
    |> String.trim()
  end

  defp normalize(strings) do
    longer_string_length =
      strings
      |> Enum.map(&String.length/1)
      |> Enum.max()

    Enum.map(strings, &fill_with_white_space(&1, longer_string_length))
  end

  defp fill_with_white_space(string, longer_string_length) do
    string <> String.duplicate(" ", longer_string_length - String.length(string))
  end

  defp to_string(row, acc \\ [])
  defp to_string([], acc), do: Enum.reverse(acc)

  defp to_string([row | other_rows], acc) do
    line = Tuple.to_list(row) |> Enum.join("")
    to_string(other_rows, [line | acc])
  end
end
