defmodule RunLengthEncoder do
  @encode_pattern ~r/(.)\1{0,}/
  @decode_pattern ~r/(\d+)?(.)/

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    Regex.replace(@encode_pattern, string, &rle_encode(&1, &2))
  end

  defp rle_encode(consecutive, elem) do
    case String.length(consecutive) do
      1 -> "#{elem}"
      count -> "#{count}#{elem}"
    end
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.replace(@decode_pattern, string, &decode_fragment(&1, &2, &3))
  end

  defp decode_fragment(_match, "", letter), do: letter

  defp decode_fragment(_match, count, letter) do
    String.duplicate(letter, String.to_integer(count))
  end
end
