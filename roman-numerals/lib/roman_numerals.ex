defmodule RomanNumerals do
  @decimal_to_roman [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    numeral(number, "")
  end

  defp numeral(0, accum), do: accum

  defp numeral(number, accum) do
    {decimal, roman} = @decimal_to_roman |> Enum.find(fn {decimal, _} -> decimal <= number end)
    numeral(number - decimal, accum <> roman)
  end
end
