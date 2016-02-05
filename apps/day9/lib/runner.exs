"lib/day9.txt"
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Day9.traveling_salesman()
  |> IO.inspect
