defmodule SecretHandshake do
  use Bitwise

  @operations %{
    0b1 => "wink",
    0b10 => "double blink",
    0b100 => "close your eyes",
    0b1000 => "jump",
    0b10000 => nil
  }

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @operations
    |> Enum.reduce([], fn step, accum -> to_operation(step, code, accum) end)
  end

  defp to_operation({operation_code, operation}, code, accum) do
    check = operation_code &&& code

    unless check == 0b10000 do
      if check == operation_code, do: accum ++ [operation], else: accum
    else
      Enum.reverse(accum)
    end
  end
end
