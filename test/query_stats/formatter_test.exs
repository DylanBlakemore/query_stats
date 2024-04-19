defmodule QueryStats.FormatterTest do
  use ExUnit.Case

  alias QueryStats.Counter
  alias QueryStats.Formatter

  setup do
    Counter.start_link()
    :ok
  end

  test "formats output" do
    Counter.increment_type("select")
    Counter.increment_type("select")
    Counter.increment_type("insert")

    assert Formatter.format_output() == """
           Total queries: 3
           Query types:
             insert: 1
             select: 2
           """
  end
end
