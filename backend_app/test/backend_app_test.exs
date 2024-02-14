defmodule BackendAppTest do
  use ExUnit.Case
  doctest BackendApp

  test "greets the world" do
    assert BackendApp.hello() == :world
  end
end
