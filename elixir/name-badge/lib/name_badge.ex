defmodule NameBadge do
  @spec print(
          id :: integer | nil,
          name :: String.t(),
          department :: String.t() | nil
        ) :: String.t()
  def print(id, name, department) do
    if id == nil do
      "#{name} - #{format_department(department)}"
    else
      "[#{id}] - #{name} - #{format_department(department)}"
    end
  end

  defp format_department(d), do: (d || "owner") |> String.upcase()
end
