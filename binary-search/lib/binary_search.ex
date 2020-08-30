defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key), do: do_search(numbers, key, 0, tuple_size(numbers) - 1)

  defp do_search({}, _key, _first, _last), do: :not_found
  defp do_search(numbers, key, _first, last) when key > elem(numbers, last), do: :not_found
  defp do_search(numbers, key, _first, _last) when key < elem(numbers, 0), do: :not_found

  defp do_search(numbers, key, first, last) do
    middle = floor((first + last) / 2)
    middle_key = elem(numbers, middle)

    cond do
      key == middle_key -> {:ok, middle}
      key < middle_key -> do_search(numbers, key, first, middle - 1)
      key > middle_key -> do_search(numbers, key, middle + 1, last)
    end
  end
end
