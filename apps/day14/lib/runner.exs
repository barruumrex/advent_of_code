reindeer_team = "lib/input.txt"
  |> File.read!()
  |> Day14.parse()

distance = reindeer_team
  |> Enum.map(fn(reindeer) -> Reindeer.fly_for(reindeer, 2503) end)
  |> Enum.max()

IO.puts "Maximum distance flown is #{distance}"

{%Reindeer{name: name}, value} = reindeer_team
  |> Day14.calc_leaderboard(2503)
  |> Enum.max_by(fn({_, val}) -> val end)

IO.puts "#{name} lead for #{value} seconds"
