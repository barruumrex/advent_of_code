relationships = "lib/input.txt"
  |> File.read!()
  |> Day13.parse()

seatings = relationships
  |> Day13.get_potential_seatings()

result = Day13.find_max_happiness(relationships, seatings)
IO.puts "Maximum happiness is #{result}"


with_me = """
Me would gain 0 happiness units by sitting next to Alice.
Me would gain 0 happiness units by sitting next to Bob.
Me would gain 0 happiness units by sitting next to Carol.
Me would gain 0 happiness units by sitting next to David.
Me would gain 0 happiness units by sitting next to Eric.
Me would gain 0 happiness units by sitting next to Frank.
Me would gain 0 happiness units by sitting next to George.
Me would gain 0 happiness units by sitting next to Mallory.
"""
relationships = "lib/input.txt"
  |> File.read!()
  |> (fn(x) -> x <> with_me end).()
  |> Day13.parse()

seatings = relationships
  |> Day13.get_potential_seatings()

result = Day13.find_max_happiness(relationships, seatings)
IO.puts "Maximum happiness including me is #{result}"
