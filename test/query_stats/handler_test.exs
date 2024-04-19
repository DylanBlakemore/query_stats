defmodule QueryStats.HandlerTest do
  use ExUnit.Case

  alias QueryStats.Counter
  alias QueryStats.Handler

  describe "attach/1" do
    test "attaches the event handler" do
      Handler.attach(:my_app)

      assert [
               %{
                 config: nil,
                 event_name: [:my_app, :repo, :query],
                 function: _function,
                 id: "query_stats"
               }
             ] = :telemetry.list_handlers([:my_app])
    end
  end

  @timings %{decode_time: 250, query_time: 296_250, total_time: 296_500}

  @query %{
    type: :ecto_sql_query,
    options: [],
    stacktrace: nil,
    result: {:ok, :result},
    params: [],
    source: "source",
    query: "INSERT INTO \"users\" (\"email\",\"name\") VALUES ($1,$2) RETURNING \"id\"",
    repo: :repo,
    cast_params: []
  }

  @event [:my_app, :repo, :query]

  describe "handle_event/4" do
    setup do
      Counter.start_link()
      :ok
    end

    test "increments the total counter" do
      assert QueryStats.Counter.get_total() == 0

      Handler.handle_event(@event, @timings, @query, :config)

      assert QueryStats.Counter.get_total() == 1
    end

    test "increments the type counter" do
      assert QueryStats.Counter.get_types() == %{}

      Handler.handle_event(@event, @timings, @query, :config)

      assert QueryStats.Counter.get_types() == %{
               "INSERT" => 1
             }
    end
  end
end
