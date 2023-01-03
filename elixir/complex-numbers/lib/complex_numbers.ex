defmodule ComplexNumbers do
  @typedoc """
  In this module, complex numbers are represented as a tuple-pair containing the real and
  imaginary parts.
  For example, the real number `1` is `{1, 0}`, the imaginary number `i` is `{0, 1}` and
  the complex number `4+3i` is `{4, 3}'.
  """
  @type complex :: {float, float}

  defp complex({a, b}), do: {a, b}
  defp complex(a), do: {a, 0}

  @doc """
  Return the real part of a complex number
  """
  @spec real(a :: complex) :: float
  def real({real, _}), do: real

  @doc """
  Return the imaginary part of a complex number
  """
  @spec imaginary(a :: complex) :: float
  def imaginary({_, imaginary}), do: imaginary

  @doc """
  Multiply two complex numbers, or a real and a complex number
  """
  @spec mul(a :: complex | float, b :: complex | float) :: complex
  def mul({a, b}, {c, d}), do: {a * c - b * d, b * c + a * d}
  def mul(a, b), do: mul(complex(a), complex(b))

  @doc """
  Add two complex numbers, or a real and a complex number
  """
  @spec add(a :: complex | float, b :: complex | float) :: complex
  def add({a, b}, {c, d}), do: {a + c, b + d}
  def add(a, b), do: add(complex(a), complex(b))

  @doc """
  Subtract two complex numbers, or a real and a complex number
  """
  @spec sub(a :: complex | float, b :: complex | float) :: complex
  def sub({a, b}, {c, d}), do: {a - c, b - d}
  def sub(a, b), do: sub(complex(a), complex(b))

  @doc """
  Divide two complex numbers, or a real and a complex number
  """
  @spec div(a :: complex | float, b :: complex | float) :: complex
  def div({a, b}, {c, d}) do
    {
      (a * c + b * d) / (:math.pow(c, 2) + :math.pow(d, 2)),
      (b * c - a * d) / (:math.pow(c, 2) + :math.pow(d, 2))
    }
  end

  def div(a, b), do: ComplexNumbers.div(complex(a), complex(b))

  @doc """
  Absolute value of a complex number
  """
  @spec abs(a :: complex) :: float
  def abs({a, b}), do: :math.sqrt(:math.pow(a, 2) + :math.pow(b, 2))

  @doc """
  Conjugate of a complex number
  """
  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}), do: {a, b * -1}

  @doc """
  Exponential of a complex number
  """
  @spec exp(a :: complex) :: complex
  def exp({a, b}) do
    {:math.exp(a) * :math.cos(b), :math.exp(a) * :math.sin(b)}
  end
end
