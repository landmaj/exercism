defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, [args | _]} = ast, acc) when op in [:def, :defp] do
    {func, arrity} = get_func_name_and_arrity(args)
    {ast, [func |> to_string() |> String.slice(0, arrity) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp get_func_name_and_arrity({:when, _, [args | _]}), do: get_func_name_and_arrity(args)
  defp get_func_name_and_arrity({name, _, args}) when is_atom(args), do: {name, 0}
  defp get_func_name_and_arrity({name, _, args}) when is_list(args), do: {name, length(args)}

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> (fn {_, acc} -> acc end).()
    |> Enum.reverse()
    |> to_string()
  end
end
