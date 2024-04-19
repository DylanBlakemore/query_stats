defmodule QueryStats do
  @moduledoc """
  QueryStats is a library that provides a way to track the number of queries executed by Ecto
  during test suite runs.

  After a run, it will output the total number of queries and the number of queries per type.

  ## Installation

  Add `query_stats` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [
      {:query_stats, "~> 0.1", only: :test}
    ]
  end
  ```

  Then, in your `test_helper.exs` file, add the following line:

  ```elixir
  QueryStats.start(:my_app)
  ```

  Replace `:my_app` with the name of your application.

  ## Output example

  ```elixir
  Total queries: 10
  Query types:
    INSERT: 5
    SELECT: 5
  ```
  """
  alias QueryStats.{Counter, Formatter, Handler}

  @doc """
  Starts the QueryStats library.

  ## Examples

    iex> QueryStats.start(:my_app)
    :ok
  """
  @spec start(atom()) :: :ok
  def start(application) do
    Counter.start_link()
    Handler.attach(application)

    ExUnit.after_suite(fn _ ->
      output = Formatter.format_output()
      IO.puts(output)
      Counter.reset()
    end)
  end
end
