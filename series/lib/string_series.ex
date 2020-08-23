defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """

  def slices(_, size) when size <= 0, do: []

  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    String.graphemes(s)
    |> parse_substr(size)
    |> Enum.filter(fn substr -> String.length(substr) >= size end)
  end

  defp parse_substr([], _), do: []

  defp parse_substr([head | tail], size) do
    substr = [head | Enum.take(tail, size - 1)] |> to_string()
    [substr | parse_substr(tail, size)]
  end
end
