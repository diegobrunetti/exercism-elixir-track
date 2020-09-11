defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    convert(string, String.length(string) - 1, 0) |> trunc()
  end

  defp convert(<<>>, _power, acc), do: acc

  defp convert(<<digit, rest::binary>>, power, acc) when digit in ?0..?1 do
    convert(rest, power - 1, acc + (digit - ?0) * :math.pow(2, power))
  end

  defp convert(_invalid_digits, _power, _acc), do: 0
end
