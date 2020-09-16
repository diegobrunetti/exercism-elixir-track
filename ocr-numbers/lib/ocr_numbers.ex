defmodule OcrNumbers do
  @numbers %{
    [" _ ", "| |", "|_|", "   "] => "0",
    ["   ", "  |", "  |", "   "] => "1",
    [" _ ", " _|", "|_ ", "   "] => "2",
    [" _ ", " _|", " _|", "   "] => "3",
    ["   ", "|_|", "  |", "   "] => "4",
    [" _ ", "|_ ", " _|", "   "] => "5",
    [" _ ", "|_ ", "|_|", "   "] => "6",
    [" _ ", "  |", "  |", "   "] => "7",
    [" _ ", "|_|", "|_|", "   "] => "8",
    [" _ ", "|_|", " _|", "   "] => "9"
  }
  @column_size 3
  @line_size 4

  defguardp is_single_line(line, acc) when length(line) == @line_size and acc == []

  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: {:ok, String.t()} | {:error, charlist()}
  def convert(input) when rem(length(input), @line_size) != 0 do
    {:error, 'invalid line count'}
  end

  def convert(input) do
    input
    |> get_columns()
    |> read_numbers([])
    |> decode("")
  end

  defp get_columns(input) do
    case input |> Enum.reduce([], &parse_columns/2) do
      {:error, msg} ->
        {:error, msg}

      columns ->
        chunk_size =
          if(length(input) == @line_size) do
            div(length(columns), @line_size)
          else
            div(length(input), @line_size)
          end

        Enum.chunk_every(columns, chunk_size)
    end
  end

  defp parse_columns(<<>>, columns), do: columns

  defp parse_columns(<<column::binary-size(@column_size), rest::binary>>, acc) do
    parse_columns(rest, [column | acc])
  end

  defp parse_columns(_invalid_input, _acc) do
    {:error, 'invalid column count'}
  end

  defp read_numbers({:error, _message} = error, _acc), do: error
  defp read_numbers([], acc), do: acc

  defp read_numbers(line, acc) when is_single_line(line, acc) do
    get_number(line)
  end

  defp read_numbers([l1, l2, l3, l4 | other_lines], acc) do
    first_line = [l1, l2, l3, l4]

    if(other_lines != []) do
      read_numbers(other_lines, acc ++ get_number(first_line) ++ [:comma])
    else
      read_numbers(other_lines, acc ++ get_number(first_line))
    end
  end

  defp get_number(line) do
    line
    |> Enum.reverse()
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp decode({:error, _message} = error, _acc), do: error

  defp decode([], acc), do: {:ok, String.reverse(acc)}
  defp decode([:comma | rest], acc), do: decode(rest, acc <> ",")
  defp decode([n | rest], acc), do: decode(rest, acc <> Map.get(@numbers, n, "?"))
end
