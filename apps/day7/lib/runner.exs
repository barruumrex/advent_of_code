defmodule Runner do
  @moduledoc """
  Script for day7 of advent of code
  """

  circuit = "lib/day7.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Day7.run_circuit()

  answer1 = Map.get(circuit, "a")
  IO.puts "Wire A contains #{answer1}"

  circuit = "lib/day7.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Day7.run_circuit(%{"b" => answer1})

  answer2 = Map.get(circuit, "a")
  IO.puts "Wire A contains #{answer2} when wire B is modified to contain #{answer2}"
end
