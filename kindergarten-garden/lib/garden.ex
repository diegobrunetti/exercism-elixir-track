defmodule Garden do
  @students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @plants %{?V => :violets, ?R => :radishes, ?G => :grass, ?C => :clover}

  @doc """
  Accepts a string representing the arrangement of cups on a windowsill and a
  list with names of students in the class. The student names list does not
  have to be in alphabetical order.

  It decodes that string into the various gardens for each student and returns
  that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    student_plants = Map.new(student_names, fn s -> {s, {}} end)
    [first_row, second_row] = String.split(info_string, "\n") |> Enum.map(&to_charlist/1)

    parse(first_row, second_row, Enum.sort(student_names), student_plants)
  end

  defp parse([], [], _students, acc), do: acc

  defp parse([p1, p2 | first_row], [p3, p4 | second_row], [student | other_students], acc) do
    plants = {@plants[p1], @plants[p2], @plants[p3], @plants[p4]}
    parse(first_row, second_row, other_students, %{acc | student => plants})
  end
end
