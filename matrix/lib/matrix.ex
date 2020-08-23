defmodule Matrix do
  @enforce_keys [:rows, :columns]
  defstruct rows: [], columns: []

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    rows = parse_rows(input)
    cols = parse_cols(rows)
    %Matrix{rows: rows, columns: cols}
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.rows
    |> Enum.map(&list_to_string/1)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix) do
    matrix.rows
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index) do
    Enum.at(matrix.rows, index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    matrix.columns
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    Enum.at(matrix.columns, index)
  end

  defp parse_rows(input) do
    String.split(input, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(&to_integer_list/1)
  end

  defp parse_cols(rows) do
    rows
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp to_integer_list(list) do
    list |> Enum.map(fn x -> String.to_integer(x) end)
  end

  defp list_to_string(list) do
    list
    |> Enum.map(&Kernel.to_string/1)
    |> Enum.join(" ")
  end
end
