defmodule LanguageList do
  @spec new :: []
  def new() do
    []
  end

  @spec add(list, String.t()) :: nonempty_list(String.t())
  def add(list, language) do
    [language | list]
  end

  @spec remove(nonempty_list(String.t())) :: list(String.t())
  def remove([_ | tail]) do
    tail
  end

  @spec first(nonempty_list(String.t())) :: String.t()
  def first([head | _]) do
    head
  end

  @spec count(list(String.t())) :: integer
  def count([]), do: 0
  def count([_ | tail]), do: 1 + count(tail)

  @spec functional_list?(list(String.T)) :: true | false
  def functional_list?([]), do: false
  def functional_list?(["Elixir" | _]), do: true
  def functional_list?([_ | tail]), do: functional_list?(tail)
end
