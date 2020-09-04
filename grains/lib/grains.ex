defmodule Grains do
  @squares_range 1..64

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: {:ok, pos_integer}
  def square(number) when number not in @squares_range do
    {:error, "The requested square must be between 1 and 64 (inclusive)"}
  end

  def square(number) do
    {:ok, grains_at(number)}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer}
  def total, do: {:ok, grains_at(65) - 1}

  defp grains_at(number), do: :math.pow(2, number - 1) |> trunc()
end
