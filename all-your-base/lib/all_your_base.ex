defmodule AllYourBase do
  defguardp is_valid_digit(digit, base) when digit >= 0 and digit < base

  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """
  @spec convert(list, integer, integer) :: list | nil
  def convert([], _base_a, _base_b), do: nil
  def convert(_digits, base_a, base_b) when base_a < 2 or base_b < 2, do: nil

  def convert(digits, base_a, base_b) do
    do_convert(to_decimal(digits, base_a, length(digits) - 1, 0), base_b, [])
  end

  defp to_decimal([], _base, _power, acc), do: trunc(acc)

  defp to_decimal([digit | _], base, _, _) when not is_valid_digit(digit, base) do
    {:error, :invalid_digit}
  end

  defp to_decimal([digit | rest], base, power, acc) when is_valid_digit(digit, base) do
    to_decimal(rest, base, power - 1, acc + digit * :math.pow(base, power))
  end

  defp do_convert({:error, _}, _to_base, _acc), do: nil
  defp do_convert(decimal, _to_base, _acc) when decimal < 0, do: nil
  defp do_convert(0, _to_base, acc) when acc != [], do: acc
  defp do_convert(0, _to_base, _acc), do: [0]

  defp do_convert(decimal, to_base, acc) do
    do_convert(div(decimal, to_base), to_base, [rem(decimal, to_base) | acc])
  end
end
