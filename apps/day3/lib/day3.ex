defmodule Day3 do
  @moduledoc """
    Helper functions for day3 of Advent of code
  """

  @typedoc """
  Tuple representing length, width, and height
  """
  @type coordinate :: {integer, integer}

  @typedoc """
  Map representing visited locations and the number of times they were visited
  """
  @type visits :: %{coordinate => integer}

  @doc """
  Take a string of directions and tell how many unique locations santa visited

  #Examples

      iex> Day3.make_deliveries(">")
      2

      iex> Day3.make_deliveries("^>v<")
      4

      iex> Day3.make_deliveries("^v^v^v^v^v")
      2
  """
  @spec make_deliveries(String.t) :: non_neg_integer
  def make_deliveries(directions) do
    directions
    |> String.graphemes
    |> Enum.reduce({{0, 0}, %{{0, 0} => 1}}, &single_move/2)
    |> calc_uniq_visits
  end

  @spec single_move(String.t, {coordinate, visits}) :: {coordinate, visits}
  defp single_move(direction, {location, visited}) do
    location
    |> move(direction)
    |> mark_visit(visited)
  end

  @spec move(coordinate, String.t) :: coordinate
  defp move({x, y}, "^"), do: {x, y + 1}
  defp move({x, y}, ">"), do: {x + 1, y}
  defp move({x, y}, "<"), do: {x - 1, y}
  defp move({x, y}, "v"), do: {x, y - 1}

  @spec mark_visit(coordinate, visits) :: {coordinate, visits}
  defp mark_visit(location, visited) do
    {location, merge_visits(location, visited)}
  end

  @spec merge_visits(coordinate, visits) :: visits
  defp merge_visits(location, visited) do
    Map.merge(%{location => 1}, visited, fn _k, v1, v2 -> v1 + v2 end)
  end

  @spec calc_uniq_visits({coordinate, visits}) :: integer
  defp calc_uniq_visits({_location, visited}), do: Enum.count(visited)
end
