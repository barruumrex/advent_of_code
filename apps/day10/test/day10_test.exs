defmodule Day10Test do
  use ExUnit.Case
  doctest Day10

  test "1 becomes 11" do
    assert Day10.look_and_say("1") == "11"
  end

  test "11 becomes 21" do
    assert Day10.look_and_say("11") == "21"
  end

  test "21 becomes 1211" do
    assert Day10.look_and_say("21") == "1211"
  end

  test "1211 becomes 111221" do
    assert Day10.look_and_say("1211") == "111221"
  end

  test "111221 becomes 312211" do
    assert Day10.look_and_say("111221") == "312211"
  end
end
