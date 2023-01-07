defmodule CustomSet do
  @opaque t :: %__MODULE__{map: map}

  defstruct map: %{}

  @spec new(Enum.t()) :: t
  def new(enumerable) do
    %__MODULE__{map: Map.from_keys(enumerable, nil)}
  end

  @spec empty?(t) :: boolean
  def empty?(custom_set) do
    custom_set.map == %{}
  end

  @spec contains?(t, any) :: boolean
  def contains?(custom_set, element) do
    Map.has_key?(custom_set.map, element)
  end

  @spec subset?(t, t) :: boolean
  def subset?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.all?(fn element -> contains?(custom_set_2, element) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.any?(fn element -> contains?(custom_set_2, element) end)
    |> then(&(not &1))
  end

  @spec equal?(t, t) :: boolean
  def equal?(custom_set_1, custom_set_2) do
    custom_set_1.map == custom_set_2.map
  end

  @spec add(t, any) :: t
  def add(%__MODULE__{map: map}, element) do
    %__MODULE__{map: Map.put(map, element, nil)}
  end

  @spec remove(t, any) :: t
  defp remove(%__MODULE__{map: map}, element) do
    %__MODULE__{map: Map.delete(map, element)}
  end

  @spec intersection(t, t) :: t
  def intersection(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.filter(fn element -> contains?(custom_set_2, element) end)
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(custom_set_1, custom_set_2) do
    custom_set_2.map
    |> Map.keys()
    |> Enum.reduce(custom_set_1, &(remove(&2, &1)))
  end

  @spec union(t, t) :: t
  def union(custom_set_1, custom_set_2) do
    custom_set_1.map
    |> Map.keys()
    |> Enum.reduce(custom_set_2, fn element, acc -> add(acc, element) end)
  end
end
