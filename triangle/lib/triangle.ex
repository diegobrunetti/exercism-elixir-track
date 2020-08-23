defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  def kind(a, b, c) when a + b <= c or a + c <= b or b + c <= a do
    {:error, "side lengths violate triangle inequality"}
  end

  def kind(a, b, c) do
    unique_side_values =
      [a, b, c]
      |> Enum.uniq()
      |> length()

    case unique_side_values do
      1 -> {:ok, :equilateral}
      2 -> {:ok, :isosceles}
      3 -> {:ok, :scalene}
    end
  end
end
