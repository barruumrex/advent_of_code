defmodule Day9 do
  require IEx
  @moduledoc """
  Helper functions for Day8 of Advent of Code
  """

  def traveling_salesman(lines) do
    mappings = get_maps(lines)
    cities = get_cities(mappings)
    paths = create_paths(cities)
    totals = walk_paths(paths, mappings)
    Enum.min_by(totals, fn({path, length}) -> length end)
  end

  defp get_maps(lines) do
    lines
    |> Enum.reduce(%{}, fn(line, acc) -> line |> parse_line() |> Map.merge(acc) end)
  end

  defp parse_line(line) do
    line
    |> String.split()
    |> do_parse_line()
  end

  defp do_parse_line([city1, "to", city2, "=", distance]) do
    edge = [city1, city2]
      |> Enum.sort()
      |> List.to_tuple()
    length = distance
      |> Integer.parse()
      |> elem(0)

    %{edge => length}
  end

  defp get_cities(mappings) do
    mappings
    |> Map.keys
    |> Enum.flat_map(&Tuple.to_list/1)
    |> Enum.uniq()
  end

  defp create_paths(cities) do
    paths = Enum.map(cities, &List.wrap/1)

    do_create_paths(paths, cities, Enum.count(cities) - 1)
  end

  defp do_create_paths(paths, _cities, 0), do: paths
  defp do_create_paths(paths, cities, iter) do
    new_paths = for x <- paths, y <- (cities -- x), do: x ++ [y]

    do_create_paths(new_paths, cities, iter - 1)
  end

  defp walk_paths(paths, distances) do
    paths
    |> Enum.map(&(walk_path(&1, distances)))
  end

  defp walk_path(path, distances) do
    path
    |> Enum.chunk(2,1)
    |> Enum.map_reduce(0, fn(x, acc) ->
      edge = x |> Enum.sort |> List.to_tuple
      length = Map.fetch!(distances, edge)
      {length, length + acc}
    end)
  end
end
