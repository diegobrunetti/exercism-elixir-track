defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """
  @spec flatten(list) :: list
  def flatten(list) do
    do_flatten(list, [])
  end

  defp do_flatten([], accum) do
    Enum.reverse(accum)
  end

  defp do_flatten([head | tail], accum) when is_list(head) do
    do_flatten(head ++ tail, accum)
  end

  defp do_flatten([head | tail], accum) do
    case head do
      nil -> do_flatten(tail, accum)
      _ -> do_flatten(tail, [head | accum])
    end
  end
end
