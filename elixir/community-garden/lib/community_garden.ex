defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  @not_found {:not_found, "plot is unregistered"}

  def start(), do: Agent.start(fn -> %{id: 1, plots: []} end)

  def list_registrations(pid), do: Agent.get(pid, fn state -> state.plots end)

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{id: id, plots: plots} ->
      plot = %Plot{plot_id: id, registered_to: register_to}
      {plot, %{id: id + 1, plots: [plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{id: id, plots: plots} ->
      %{id: id, plots: Enum.reject(plots, &(&1.plot_id == plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      Enum.find(plots, @not_found, &(&1.plot_id == plot_id))
    end)
  end
end
