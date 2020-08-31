defmodule IsbnVerifier do
  @starting_weight 10

  defguardp is_valid_check_character(check) when check in ?0..?9 or check == ?X

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
    |> apply_formula(0, @starting_weight)
  end

  defp format(<<check, digits::binary>>) when is_valid_check_character(check) do
    <<check>> <> for(<<d <- digits>>, d in ?0..?9, into: "", do: <<d>>)
  end

  defp format(_invalid_isbn), do: :invalid_isbn

  defp apply_formula(:invalid_isbn, _sum, _weight), do: false
  defp apply_formula(<<>>, sum, _weight), do: rem(sum, 11) == 0

  defp apply_formula(<<first, rest::binary>>, sum, weight) do
    sum_so_far = to_integer(first) * weight + sum
    apply_formula(rest, sum_so_far, weight - 1)
  end

  defp to_integer(?X), do: 10
  defp to_integer(digit), do: digit - ?0
end
