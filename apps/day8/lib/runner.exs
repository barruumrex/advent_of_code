"lib/day8.txt"
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn(line, acc) -> acc + Day8.memory_diff(line) end)
  |> IO.inspect()

"lib/day8.txt"
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.reduce(0, fn(line, acc) -> acc + Day8.escape_diff(line) end)
  |> IO.inspect()

