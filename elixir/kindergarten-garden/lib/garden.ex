defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @names ~w(alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry)a

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names) do
    student_names = Enum.sort(student_names)

    info_string
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.graphemes()
      |> Enum.map(&plant/1)
      |> Enum.chunk_every(2)
    end)
    |> Enum.zip()
    |> Enum.map(fn {a, b} -> (a ++ b) |> List.to_tuple() end)
    |> Enum.zip(student_names)
    |> Enum.reduce(
      Map.from_keys(student_names, {}),
      fn {plants, name}, students -> %{students | name => plants} end
    )
  end

  defp plant("C"), do: :clover
  defp plant("G"), do: :grass
  defp plant("R"), do: :radishes
  defp plant("V"), do: :violets
end
