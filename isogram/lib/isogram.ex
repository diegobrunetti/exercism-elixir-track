defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/([[:alpha:]])(?=.*\1)/u, "")
    |> (&(&1 == sentence)).()
  end
end
