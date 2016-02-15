defmodule Day13Test do
  use ExUnit.Case
  doctest Day13

  test "Parse line" do
    string = "Alice would gain 54 happiness units by sitting next to Bob."
    result = {{"Alice", "Bob"}, 54}
    assert Day13.parse_line(string) == result
  end

  test "Parse negative line" do
    string = "Alice would lose 79 happiness units by sitting next to Carol."
    result = {{"Alice", "Carol"}, -79}
    assert Day13.parse_line(string) == result
  end

  test "Parse all lines" do
    string = ~s(Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol.)
    result = %{{"Alice", "Bob"} => 54, {"Alice", "Carol"} => -79}
    assert Day13.parse(string) == result
  end

  test "Get possible seating arrangements from relationships" do
    relationships = %{{"Alice", "Bob"} => 1,
                      {"Alice", "Carol"} => 1,
                      {"Bob", "Alice"} => 1,
                      {"Bob", "Carol"} => 1,
                      {"Carol", "Alice"} => 1,
                      {"Carol", "Bob"} => 1}
    result = [["Carol", "Bob", "Alice", "Carol"], ["Bob", "Carol", "Alice", "Bob"]]
    assert Day13.get_potential_seatings(relationships) == result
  end

  test "Find largest total" do
    relationships = %{{"Alice", "Bob"} => 4,
                      {"Alice", "Carol"} => 7,
                      {"Bob", "Carol"} => 10}
    seats = [["Carol", "Bob", "Alice", "Carol"], ["Bob", "Carol", "Alice", "Bob"]]
    assert Day13.find_max_happiness(relationships, seats) == 21
  end
end
