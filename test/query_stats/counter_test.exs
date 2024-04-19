defmodule QueryStats.CounterTest do
  use ExUnit.Case

  alias QueryStats.Counter

  setup do
    Counter.start_link()
    :ok
  end

  test "increments total" do
    assert Counter.get_total() == 0
    Counter.increment_total()
    assert Counter.get_total() == 1
  end

  test "increments type" do
    assert Counter.get_types() == %{}
    Counter.increment_type("select")
    assert Counter.get_types() == %{"select" => 1}
    Counter.increment_type("select")
    assert Counter.get_types() == %{"select" => 2}
    Counter.increment_type("insert")
    assert Counter.get_types() == %{"select" => 2, "insert" => 1}

    assert Counter.get_total() == 3
  end

  test "resets counter" do
    Counter.increment_total()
    Counter.increment_type("select")
    Counter.increment_type("insert")
    Counter.reset()
    assert Counter.get_total() == 0
    assert Counter.get_types() == %{}
  end
end
