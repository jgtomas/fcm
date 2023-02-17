defmodule FcmTest do
  use ExUnit.Case
  doctest Fcm

  test "greets the world" do
    assert Fcm.hello() == :world
  end
end
