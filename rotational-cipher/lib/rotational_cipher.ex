defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> to_charlist
    |> Enum.map(&rot(&1, shift))
    |> to_string()
  end

  defp rot(char, shift) when shift == 26, do: char

  defp rot(char, shift) do
    cond do
      char in ?A..?Z -> rem(char - ?A + shift, 26) + ?A
      char in ?a..?z -> rem(char - ?a + shift, 26) + ?a
      true -> char
    end
  end
end
