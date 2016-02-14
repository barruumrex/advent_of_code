defmodule Day12Test do
  use ExUnit.Case
  doctest Day12

  test "Sum simple array" do
    assert Day12.sum([1,2,3]) == 6
  end

  test "Sum simple hash" do
    assert Day12.sum(%{"a": 2, "b": 4}) == 6
  end

  test "Sum nested list" do
    assert Day12.sum([[[3]]]) == 3
  end

  test "Sum nested hash" do
    assert Day12.sum(%{"a": %{"b": 4}, "c": -1}) == 3
  end

  test "Sum empty list" do
    assert Day12.sum([]) == 0
  end

  test "Sum empty map" do
    assert Day12.sum(%{}) == 0
  end

  test "Hash with list" do
    assert Day12.sum(%{"a": [-1, 1]}) == 0
  end

  test "List with nested hash" do
    assert Day12.sum([-1, %{"a": 1}]) == 0
  end
end
