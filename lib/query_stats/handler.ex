defmodule QueryStats.Handler do
  @moduledoc """
  This module is responsible for handling events and attaching to the application telemetry.
  """
  alias QueryStats.Counter

  @doc """
  Attaches the handler to the application telemetry.
  """
  @spec attach(atom()) :: :ok
  def attach(application) do
    :telemetry.attach(
      "query_stats",
      [application, :repo, :query],
      &__MODULE__.handle_event/4,
      nil
    )
  end

  @doc """
  Handles the query event by incrementing the query statistics.
  """
  @spec handle_event(list(atom()), map(), map(), any()) :: :ok
  def handle_event(_event, _timings, query, _) do
    query_type =
      query.query
      |> String.split(" ")
      |> List.first()

    Counter.increment_type(query_type)
  end
end
