defmodule Runner do
  @moduledoc """
  Script for day7 of advent of code
  """

  circuit = "lib/day7.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Day7.run_circuit()

  answer = Map.get(circuit, "a")
  IO.puts "Wire A contains #{answer}"
end
