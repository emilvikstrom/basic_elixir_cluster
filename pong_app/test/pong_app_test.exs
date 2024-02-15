defmodule PongAppTest do
  use ExUnit.Case
  doctest PongApp

  test "greets the world" do
    assert PongApp.hello() == :world
  end
end
