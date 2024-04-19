# QueryStats

![CI Pipeline](https://github.com/dylanblakemore/query_stats/actions/workflows/elixir.yml/badge.svg)
[![Hex.pm](https://img.shields.io/hexpm/v/query_stats.svg)](https://hex.pm/packages/query_stats)
[![Documentation](https://img.shields.io/badge/documentation-gray)](https://hexdocs.pm/query_stats/api-reference.html)

QueryStats is a library that provides a way to track the number of queries executed by Ecto
during test suite runs.

After a run, it will output the total number of queries and the number of queries per type.

## Output example

```elixir
Total queries: 10
Query types:
  INSERT: 5
  SELECT: 5
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `query_stats` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:query_stats, "~> 0.1.0", only: [:test]}
  ]
end
```

Then, in your `test_helper.exs` file, add the following line:

```elixir
QueryStats.start(:my_app)
```

Replace `:my_app` with the name of your application.
