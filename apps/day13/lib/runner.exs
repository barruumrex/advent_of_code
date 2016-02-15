require IEx

relationships = "lib/input.txt"
  |> File.read!()
  |> Day13.parse()

seatings = relationships
  |> Day13.get_potential_seatings()

result = Day13.find_max_happiness(relationships, seatings)
IO.puts "Maximum happiness is #{result}"

