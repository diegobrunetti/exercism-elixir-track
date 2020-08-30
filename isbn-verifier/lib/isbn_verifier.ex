defmodule IsbnVerifier do
  @allowed_chars ~r/[^[:digit:][:upper:]]/u
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    isbn
    |> format()
    |> apply_formula()
  end

  defp format(isbn) do
    isbn
    |> String.replace(@allowed_chars, "")
    |> to_charlist()
    |> Enum.map(&to_integer/1)
  end

  defp apply_formula([]), do: false

  defp apply_formula(digits) when length(digits) == 10 do
    digits
    |> Enum.zip(10..1)
    |> Enum.reduce(0, fn {digit, multiplier}, acc -> digit * multiplier + acc end)
    |> rem(11) == 0
  end

  defp apply_formula(_), do: false

  defp to_integer(?X), do: 10
  defp to_integer(digit) when digit in ?0..?9, do: digit - ?0
  defp to_integer(_invalid), do: 666
end
