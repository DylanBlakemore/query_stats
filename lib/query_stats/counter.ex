defmodule QueryStats.Counter do
  use Agent

  @default %{total: 0, types: %{}}

  @spec start_link() :: {:ok, pid()} | {:error, term()}
  def start_link do
    Agent.start_link(fn -> @default end, name: __MODULE__)
  end

  @spec increment_total() :: :ok
  def increment_total do
    Agent.update(__MODULE__, fn state ->
      count = state.total + 1
      %{state | total: count}
    end)
  end

  @spec increment_type(String.t()) :: :ok
  def increment_type(type) do
    Agent.update(__MODULE__, fn state ->
      types = Map.update(state.types, type, 1, &(&1 + 1))
      %{state | types: types, total: state.total + 1}
    end)
  end

  @spec get_total() :: integer()
  def get_total do
    Agent.get(__MODULE__, fn state -> state.total end)
  end

  @spec get_types() :: map()
  def get_types do
    Agent.get(__MODULE__, fn state -> state.types end)
  end

  @spec reset() :: :ok
  def reset do
    Agent.update(__MODULE__, fn _state -> @default end)
  end
end
