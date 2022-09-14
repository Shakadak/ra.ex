defmodule RaTest do
  use ExUnit.Case
  doctest Ra

  test "greets the world" do
    assert Ra.hello() == :world
  end
end
