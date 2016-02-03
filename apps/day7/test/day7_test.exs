defmodule Day7Test do
  use ExUnit.Case
  doctest Day7

  test "simple circuit" do
    circuit = [
      "f -> z",
      "x AND y -> d",
      "x OR y -> e",
      "x LSHIFT 2 -> f",
      "y RSHIFT 2 -> g",
      "NOT x -> h",
      "NOT y -> i",
      "123 -> x",
      "456 -> y",
    ]

    results = %{
      "d" => 72,
      "e" => 507,
      "f" => 492,
      "g" => 114,
      "h" => 65412,
      "i" => 65079,
      "x" => 123,
      "y" => 456,
      "z" => 492,
    }

    wires = Day7.run_circuit(circuit)

    assert wires |> Map.get("d") == Map.get(results,"d")
    assert wires |> Map.get("e") == Map.get(results,"e")
    assert wires |> Map.get("f") == Map.get(results,"f")
    assert wires |> Map.get("g") == Map.get(results,"g")
    assert wires |> Map.get("h") == Map.get(results,"h")
    assert wires |> Map.get("i") == Map.get(results,"i")
    assert wires |> Map.get("x") == Map.get(results,"x")
    assert wires |> Map.get("y") == Map.get(results,"y")
    assert wires |> Map.get("z") == Map.get(results,"z")
  end

  test "assignment operator" do
    assert (Day7.create_gate(["123", "->", "x"], %{}) |> Map.get("x")).(%{}) == 123
  end

  test "tricky assignment operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["x", "->", "bk"], test_circuit) |> Map.get("bk")).(test_circuit) == 123
  end

  test "AND operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["x", "AND", "y", "->", "d"], test_circuit) |> Map.get("d")).(test_circuit) == 72
  end

  test "OR operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["x", "OR", "y", "->", "e"], test_circuit) |> Map.get("e")).(test_circuit) == 507
  end

  test "LSHIFT operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["x", "LSHIFT", "2", "->", "f"], test_circuit) |> Map.get("f")).(test_circuit) == 492
  end

  test "RSHIFT operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["y", "RSHIFT", "2", "->", "g"], test_circuit) |> Map.get("g")).(test_circuit) == 114
  end

  test "NOT operator" do
    test_circuit = %{"x" => 123, "y" => 456}
    assert (Day7.create_gate(["NOT", "x", "->", "h"], test_circuit) |> Map.get("h")).(test_circuit) == 65412
  end
end
