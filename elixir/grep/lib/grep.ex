defmodule Grep do
  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags, files) do
    flags = %{
      caseless: "-i" in flags,
      entire_lines: "-x" in flags,
      filenames: "-l" in flags,
      numbered: "-n" in flags,
      prefixed: length(files) > 1,
      reversed: "-v" in flags
    }

    Enum.flat_map(files, &grep_file(&1, matcher(pattern, flags)))
    |> prepare_output(flags)
  end

  defp matcher(pattern, flags) do
    pattern
    |> entire_line(flags.entire_lines)
    |> caseless(flags.caseless)
    |> reversed(flags.reversed)
  end

  defp entire_line(pattern, true), do: "^#{pattern}$"
  defp entire_line(pattern, _), do: pattern

  defp caseless(pattern, true), do: Regex.compile!(pattern, [:caseless])
  defp caseless(pattern, _), do: Regex.compile!(pattern)

  defp reversed(pattern, true), do: fn line -> not Regex.match?(pattern, line) end
  defp reversed(pattern, _), do: fn line -> Regex.match?(pattern, line) end

  defp grep_file(filename, matcher) do
    filename
    |> File.stream!()
    |> Enum.with_index(fn line, index -> {line, filename, index + 1} end)
    |> Enum.filter(fn {line, _, _} -> matcher.(line) end)
  end

  defp prepare_output(lines, %{filenames: true}) do
    lines
    |> Enum.map(fn {_, filename, _} -> "#{filename}\n" end)
    |> Enum.uniq()
    |> Enum.join()
  end

  defp prepare_output(lines, %{numbered: numbered, prefixed: prefixed}) do
    lines
    |> Enum.map(&format_line(&1, numbered, prefixed))
    |> Enum.join()
  end

  defp format_line(line, add_index, add_filename) do
    line
    |> with_index(add_index)
    |> with_filename(add_filename)
    |> then(fn {line, _, _} -> "#{line}" end)
  end

  defp with_index({line, filename, index}, true), do: {"#{index}:#{line}", filename, index}
  defp with_index(line, _), do: line

  defp with_filename({line, filename, index}, true), do: {"#{filename}:#{line}", filename, index}
  defp with_filename(line, _), do: line
end
