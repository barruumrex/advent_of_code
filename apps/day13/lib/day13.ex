defmodule Day13 do
  @moduledoc """
  Helper functions for day13 of Advent of Code
  """

  @type relationship :: {{String.t, String.t}, integer}
  @type relationships :: %{{String.t, String.t} => integer}

  @doc """
  Parse full input from file
  """
  @spec parse(String.t) :: relationships
  def parse(lines) do
    lines
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &add_relationship/2)
  end

  defp add_relationship({key, value}, acc) do
    key = key
      |> Tuple.to_list()
      |> Enum.sort()
      |> List.to_tuple()

    Map.merge(acc, %{key => value}, fn(_k, v1, v2) -> v1 + v2 end)
  end

  @doc """
  Parse a single line into its relationship representation

  ## Examples

      iex> Day13.parse_line("Bob would gain 83 happiness units by sitting next to Alice.")
      {{"Bob", "Alice"}, 83}

      iex> Day13.parse_line("Bob would lose 7 happiness units by sitting next to Carol.")
      {{"Bob", "Carol"}, -7}
  """
  @spec parse_line(String.t) :: relationship
  def parse_line(line) do
    filler = ["would", "happiness units by sitting next to", ".", " "]

    line
    |> String.split(filler, trim: true)
    |> parse_parts()
  end

  @spec parse_parts(list(String.t)) :: relationship
  defp parse_parts([left, "gain", number, right]), do: {{left, right}, number |> Integer.parse() |> elem(0)}
  defp parse_parts([left, "lose", number, right]), do: {{left, right}, -(number |> Integer.parse() |> elem(0))}

  @doc """
  Find seating permutations
  """
  @spec get_potential_seatings(relationships) :: list(list(String.t))
  def get_potential_seatings(relationships) do
    relationships
      |> Enum.flat_map(fn({key, value}) -> key |> Tuple.to_list end)
      |> Enum.uniq()
      |> create_seatings()
  end

  @spec create_seatings(list(String.t)) :: list(list(String.t))
  defp create_seatings([person | rest]), do: do_create_seatings([person], rest)

  @spec do_create_seatings(list(String.t), list(String.t)) :: list(list(String.t))
  defp do_create_seatings(seats, []), do: [seats ++ [hd(seats)]]
  defp do_create_seatings(seats, potentials) do
    new_seats = for x <- potentials, do: [x | seats]

    Enum.reduce(new_seats, [], fn(seats, acc) -> acc ++ do_create_seatings(seats, potentials -- seats) end)
  end

  @doc """
  Return happiness value for the best seating arrangement
  """
  @spec find_max_happiness(relationships, list(list(String.t))) :: integer
  def find_max_happiness(relationships, potential_seats) do
    potential_seats
    |> Enum.map(fn(seats) -> sum_happiness(relationships, seats) end)
    |> Enum.max()
  end

  @spec sum_happiness(relationships, list(String.t)) :: integer
  defp sum_happiness(relationships, seats) do
    seats
    |> Enum.chunk(2,1)
    |> Enum.map(fn(pair) -> pair |> Enum.sort() |> List.to_tuple() end)
    |> Enum.map(fn(pair) -> Map.get(relationships, pair) end)
    |> Enum.sum()
  end
end
