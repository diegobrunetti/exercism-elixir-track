defmodule MatchingBrackets do
  @not_brackets ~r/[^\[\]\(\)\{\}]/
  @opening ["[", "{", "("]
  @closing ["]", "}", ")"]
  @closing_of %{
    "{" => "}",
    "[" => "]",
    "(" => ")"
  }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(@not_brackets, "")
    |> String.graphemes()
    |> Enum.reduce_while([], fn char, accum -> parse(char, accum) end)
    |> is_stack_empty?()
  end

  defp parse(bracket, stack) when bracket in @opening do
    {:cont, push(bracket, stack)}
  end

  defp parse(bracket, stack) when bracket in @closing do
    {opening, updated_stack} = pop(stack)

    if @closing_of[opening] == bracket do
      {:cont, updated_stack}
    else
      {:halt, push(bracket, stack)}
    end
  end

  defp push(char, stack), do: stack ++ [char]
  defp pop(stack), do: List.pop_at(stack, -1)
  defp is_stack_empty?(stack), do: length(stack) == 0
end
