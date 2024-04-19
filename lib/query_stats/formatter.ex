defmodule QueryStats.Formatter do
  alias QueryStats.Counter

  @spec format_output() :: String.t()
  def format_output do
    total = Counter.get_total()
    types = Counter.get_types()

    types_str =
      types
      |> Map.to_list()
      |> Enum.sort_by(&elem(&1, 1))
      |> Enum.map_join("\n", fn {k, v} -> "  #{k}: #{v}" end)

    """
    Total queries: #{total}
    Query types:
    #{types_str}
    """
  end
end
