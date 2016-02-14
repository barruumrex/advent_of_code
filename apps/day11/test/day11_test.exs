defmodule Day11Test do
  use ExUnit.Case
  doctest Day11

  test "Increment fails if not exactly 8 characters" do
    assert_raise(ArgumentError, fn -> Day11.increment("a") end)
  end

  test "Increment increments the last letter" do
    assert Day11.increment("aaaaaaaa") == "aaaaaaab"
  end

  test "Incrementing \"z\" rolls over to next letter" do
    assert Day11.increment("aaaaaaaz") == "aaaaaaba"
  end

  test "Incrementing all z's rolls over to all a's" do
    assert Day11.increment("zzzzzzzz") == "aaaaaaaa"
  end
end
