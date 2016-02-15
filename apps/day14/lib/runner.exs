distance = "lib/input.txt"
  |> File.read!()
  |> Day14.parse()
  |> Enum.map(fn(reindeer) -> Reindeer.fly_for(reindeer, 2503) end)
  |> Enum.max()

IO.puts "Maximum distance flown is #{distance}"
