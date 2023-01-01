defmodule Matrix do
  @enforce_keys [:data, :height, :width]
  defstruct [:data, :height, :width]

  @type t :: %__MODULE__{}

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: Matrix.t()
  def from_string(input) do
    matrix =
      input
      |> String.split("\n")
      |> Enum.map(fn row ->
        row
        |> String.split()
        |> Enum.map(&String.to_integer/1)
      end)

    %__MODULE__{
      data: matrix,
      height: length(matrix),
      width: matrix |> Enum.at(0) |> length()
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: Matrix.t()) :: String.t()
  def to_string(matrix) do
    matrix.data
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: Matrix.t()) :: list(list(integer))
  def rows(matrix), do: matrix.data

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: Matrix.t(), index :: integer) :: list(integer)
  def row(matrix, index), do: Enum.at(matrix.data, index - 1)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: Matrix.t()) :: list(list(integer))
  def columns(matrix) do
    for index <- 1..matrix.width do
      column(matrix, index)
    end
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: Matrix.t(), index :: integer) :: list(integer)
  def column(matrix, index), do: Enum.map(matrix.data, &Enum.at(&1, index - 1))
end
