defmodule QueryStats.Counter do
  @moduledoc """
  This module is responsible for keeping track of query statistics.
  """
  use Agent

  @default %{total: 0, types: %{}}

  @doc """
  Starts the counter agent.
  """
  @spec start_link() :: {:ok, pid()} | {:error, term()}
  def start_link do
    Agent.start_link(fn -> @default end, name: __MODULE__)
  end

  @doc """
  Increments the total count of queries.
  """
  @spec increment_total() :: :ok
  def increment_total do
    Agent.update(__MODULE__, fn state ->
      count = state.total + 1
      %{state | total: count}
    end)
  end

  @doc """
  Increments the count of a specific query type.
  """
  @spec increment_type(String.t()) :: :ok
  def increment_type(type) do
    Agent.update(__MODULE__, fn state ->
      types = Map.update(state.types, type, 1, &(&1 + 1))
      %{state | types: types, total: state.total + 1}
    end)
  end

  @doc """
  Returns the total count of queries.
  """
  @spec get_total() :: integer()
  def get_total do
    Agent.get(__MODULE__, fn state -> state.total end)
  end

  @doc """
  Returns the count of each query type.
  """
  @spec get_types() :: map()
  def get_types do
    Agent.get(__MODULE__, fn state -> state.types end)
  end

  @doc """
  Resets the counter.
  """
  @spec reset() :: :ok
  def reset do
    Agent.update(__MODULE__, fn _state -> @default end)
  end
end
