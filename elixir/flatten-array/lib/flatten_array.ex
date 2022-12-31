defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(nil), do: []
  def flatten(v) when not is_list(v), do: [v]

  def flatten(list) do
    Enum.reduce(list, [], fn element, acc -> acc ++ flatten(element) end)
  end

end
