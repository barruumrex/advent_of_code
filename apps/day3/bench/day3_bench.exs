defmodule Day3Bench do
  use Benchfella

  bench "deliveries" do
    "lib/day3.txt"
    |> File.read!
    |> String.strip
    |> Day3.make_deliveries
    |> IO.puts
  end
end
