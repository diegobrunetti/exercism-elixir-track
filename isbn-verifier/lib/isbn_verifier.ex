defmodule IsbnVerifier do
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
    String.reverse(isbn)
    |> format()
    |> apply_formula(0, 10)
  end

  defp format(<<check, digits::binary>>) when check in ?0..?9 or check == ?X do
    <<check>> <> for(<<c <- digits>>, c in ?0..?9, into: "", do: <<c>>)
  end

  defp format(_invalid_isbn), do: :invalid

  defp apply_formula(:invalid, _, _), do: false
  defp apply_formula(<<>>, acc, _weight), do: rem(acc, 11) == 0

  defp apply_formula(<<first, rest::binary>>, acc, weight) do
    sum_so_far = to_integer(first) * weight + acc
    apply_formula(rest, sum_so_far, weight - 1)
  end

  defp to_integer(?X), do: 10
  defp to_integer(digit), do: digit - ?0
end
