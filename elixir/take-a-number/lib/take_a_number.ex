defmodule TakeANumber do
  defp loop(n \\ 0) do
    receive do
      :stop ->
        nil

      {:report_state, pid} ->
        pid |> send(n)
        loop(n)

      {:take_a_number, pid} ->
        pid |> send(n + 1)
        loop(n + 1)

      _ ->
        loop(n)
    end
  end

  @spec start :: pid
  def start() do
    spawn(&loop/0)
  end
end
