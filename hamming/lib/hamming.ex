defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    compare(strand1, strand2)
  end

  defp compare('', ''), do: ok(0)
  defp compare(a, b) when length(a) != length(b), do: error()

  defp compare(a, b) do
    Enum.zip(a, b)
    |> Enum.filter(fn {a, b} -> a != b end)
    |> Enum.count()
    |> ok()
  end

  defp ok(count), do: {:ok, count}
  defp error(), do: {:error, "Lists must be the same length"}
end
