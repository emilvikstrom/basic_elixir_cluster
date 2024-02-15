defmodule PingAppTest do
  use ExUnit.Case
  doctest PingApp

  test "greets the world" do
    assert PingApp.hello() == :world
  end
end
