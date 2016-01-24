defmodule Day4Bench do
  use Benchfella

  bench "coins with 5 zeroes" do
    "lib/day4.txt"
    |> File.read!
    |> String.strip
    |> Day4.find_coin(5)
  end

  bench "coins with 6 zeroes" do
    "lib/day4.txt"
    |> File.read!
    |> String.strip
    |> Day4.find_coin(6)
  end
end
