defmodule Day9 do
  @moduledoc """
  Helper functions for Day9 of Advent of Code
  """

  def traveling_salesman(lines) do
    paths = lines
      |> get_edges()
      |> calc_paths()

    [shortest_path(paths), longest_path(paths)]
  end

  defp get_edges(lines) do
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

  defp calc_paths(edges) do
    edges
    |> get_cities()
    |> create_paths()
    |> walk_paths(edges)
  end

  defp get_cities(edges) do
    edges
    |> Map.keys()
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
    |> Enum.map_reduce(0, fn(cities, acc) ->
      edge = cities |> Enum.sort |> List.to_tuple
      length = Map.fetch!(distances, edge)

      {length, length + acc}
    end)
  end

  defp shortest_path(paths) do
    paths
    |> Enum.min_by(fn({path, length}) -> length end)
  end

  defp longest_path(paths) do
    paths
    |> Enum.max_by(fn({path, length}) -> length end)
  end
end
