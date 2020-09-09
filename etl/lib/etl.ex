defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, &do_transform/2)
  end

  defp do_transform({_score, []}, acc), do: acc

  defp do_transform({score, [word | other_words]}, acc) do
    do_transform({score, other_words}, Map.put(acc, String.downcase(word), score))
  end
end
