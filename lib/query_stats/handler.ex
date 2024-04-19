defmodule QueryStats.Handler do
  @moduledoc """
  This module is responsible for handling events and attaching to the application telemetry.
  """
  alias QueryStats.Counter

  @spec attach(atom()) :: :ok
  def attach(application) do
    :telemetry.attach(
      "query_stats",
      [application, :sql, :query],
      &__MODULE__.handle_event/4,
      application
    )
  end

  @spec handle_event(list(atom()), map(), map(), any()) :: :ok
  def handle_event(_event, _timings, query, _) do
    query_type =
      query.query
      |> String.split(" ")
      |> List.first()

    Counter.increment_type(query_type)
  end
end
