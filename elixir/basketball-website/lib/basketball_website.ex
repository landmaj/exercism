defmodule BasketballWebsite do
  @spec extract_from_path(any, String.t()) :: [any]
  def extract_from_path(data, path) do
    path
    |> String.split(".")
    |> then(&do_extract_from_path(data, &1))
  end

  defp do_extract_from_path(data, [h | []]), do: data[h]
  defp do_extract_from_path(data, [h | t]), do: do_extract_from_path(data[h], t)

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
