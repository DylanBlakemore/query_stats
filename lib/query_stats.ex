defmodule QueryStats do
  alias QueryStats.{Counter, Formatter, Handler}

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
