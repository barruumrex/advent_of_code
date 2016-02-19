reindeer_team = "lib/input.txt"
  |> File.read!()
  |> Day14.parse()

distance = reindeer_team
  |> Enum.map(fn(reindeer) -> Reindeer.fly_for(reindeer, 2503) end)
  |> Enum.max()

IO.puts "Maximum distance flown is #{distance}"

1..2503
|> Enum.reduce(%{}, fn(x, acc)
  -> reindeer_team
    |> Day14.calc_leaderboard(x, acc)
  end)
|> IO.inspect
