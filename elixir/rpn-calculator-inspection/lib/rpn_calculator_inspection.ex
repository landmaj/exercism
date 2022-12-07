defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    {:ok, pid} = Task.start_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    result =
      receive do
        {:EXIT, ^pid, :normal} -> :ok
        {:EXIT, ^pid, _} -> :error
      after
        100 -> :timeout
      end

    Map.put(results, input, result)
  end

  def reliability_check(calculator, inputs) do
    old_flag = Process.flag(:trap_exit, true)

    checks =
      inputs
      |> Enum.map(fn input -> start_reliability_check(calculator, input) end)
      |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, old_flag)
    checks
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end
end
