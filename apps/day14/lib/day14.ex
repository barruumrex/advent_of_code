defmodule Day14 do
  @moduledoc """
  Helper functions for Day14 of Advent of Code
  """

  @type reindeer_team :: list(Reindeer.t)

  @doc """
  Parse full input from file
  """
  @spec parse(String.t) :: reindeer_team
  def parse(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  @doc """
  Parse a line and return a Reindeer

  ## Examples

      iex> Day14.parse_line("Cupid can fly 25 km/s for 6 seconds, but then must rest for 145 seconds.")
      %Reindeer{name: "Cupid", speed: 25, fly_time: 6, rest_time: 145}
  """
  @spec parse_line(String.t) :: Reindeer.t
  def parse_line(line) do
    filler = ["can fly", "km/s for", "seconds, but then must rest for", "seconds.", " "]

    line
    |> String.split(filler, trim: true)
    |> List.to_tuple()
    |> Reindeer.new()
  end
end

defmodule Reindeer do
  @moduledoc """
  Representation of Reindeer for Day14 of Advent of Code
  """
  defstruct name: "Comet", speed: 14, fly_time: 10, rest_time: 127
  @type t :: %Reindeer{name: String.t, speed: non_neg_integer, fly_time: non_neg_integer, rest_time: non_neg_integer}

  @doc """
  Caclulate distance for a reindeer flying for a specified time

  ## Examples

      iex> Reindeer.fly_for(%Reindeer{speed: 10, fly_time: 10, rest_time: 10}, 5)
      50

      iex> Reindeer.fly_for(%Reindeer{speed: 10, fly_time: 10, rest_time: 10}, 15)
      100

      iex> Reindeer.fly_for(%Reindeer{speed: 10, fly_time: 10, rest_time: 10}, 27)
      170

      iex> Reindeer.fly_for(%Reindeer{speed: 10, fly_time: 10, rest_time: 10}, 37)
      200
  """
  @spec fly_for(Reindeer.t, non_neg_integer) :: non_neg_integer
  def fly_for(reindeer, time) do
    reindeer.speed * calculate_flight_time(reindeer.fly_time, reindeer.rest_time, time)
  end

  @spec calculate_flight_time(non_neg_integer, non_neg_integer, non_neg_integer) :: non_neg_integer
  defp calculate_flight_time(fly_time, rest_time, time) do
    cycle_time = fly_time + rest_time
    cycles = trunc(time / cycle_time)
    remaining_time = rem(time, cycle_time)

    (cycles * fly_time) + Enum.min([fly_time, remaining_time])
  end

  @doc """
  Create a Reindeer from a tuple.

  ## Examples

      iex> Reindeer.new({"Rudolph", "3", "15", "28"})
      %Reindeer{name: "Rudolph", speed: 3, fly_time: 15, rest_time: 28}
  """
  @spec new({String.t, String.t, String.t, String.t}) :: Reindeer.t
  def new({name, speed, fly_time, rest_time}) do
    %Reindeer{name: name,
              speed: String.to_integer(speed),
              fly_time: String.to_integer(fly_time),
              rest_time: String.to_integer(rest_time)}
  end
end
