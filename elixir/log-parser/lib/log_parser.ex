defmodule LogParser do
  def valid_line?(line) do
    line =~ ~r/^\[DEBUG|INFO|WARNING|ERROR\]/
  end

  def split_line(line) do
    Regex.split(~r/<[~*=-]*>/, line)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/end-of-line\d+/i, line, "")
  end

  def tag_with_user_name(line) do
    Regex.run(~r/User\s+(\S+)/, line) |> prefix_line_with_user(line)
  end

  defp prefix_line_with_user(nil, line), do: line

  defp prefix_line_with_user([_ | [user | _]], line) do
    "[USER] #{user} #{line}"
  end
end
