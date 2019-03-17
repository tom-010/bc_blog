defmodule WebWriterTest do
  use ExUnit.Case
  doctest WebWriter

  test "greets the world" do
    assert WebWriter.hello() == :world
  end
end
