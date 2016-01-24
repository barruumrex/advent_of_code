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
    |> run_route
    |> calc_uniq_visits
  end

  @spec run_route([String.t]) :: {coordinate, visits}
  defp run_route(moves) do
    Enum.reduce(moves, {{0, 0}, %{{0, 0} => 1}}, &single_move/2)
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

  @spec calc_uniq_visits({coordinate, visits}) :: non_neg_integer
  defp calc_uniq_visits({_location, visited}), do: Enum.count(visited)

  @doc """
  Take a string of directions and tell how many unique locations santa and his robot visited

  #Examples

      iex> Day3.robo_deliveries("^v")
      3

      iex> Day3.robo_deliveries("^>v<")
      3

      iex> Day3.robo_deliveries("^v^v^v^v^v")
      11
  """
  @spec robo_deliveries(String.t) :: non_neg_integer
  def robo_deliveries(directions) do
    directions
    |> String.graphemes
    |> split_directions
    |> run_routes
    |> Enum.count
  end

  @spec split_directions([String.t]) :: {[String.t], [String.t]}
  defp split_directions(directions) do
    do_split_directions(directions, [], [])
  end

  @spec do_split_directions([String.t], [String.t], [String.t]) :: {[String.t], [String.t]}
  defp do_split_directions([], santa_list, robot_list), do: {Enum.reverse(santa_list), Enum.reverse(robot_list)}
  defp do_split_directions([santa_move | []], santa_list, robot_list) do
    do_split_directions([], [santa_move | santa_list], robot_list)
  end
  defp do_split_directions([santa_move, robot_move | tail], santa_list, robot_list) do
    do_split_directions(tail, [santa_move | santa_list], [robot_move | robot_list])
  end

  @spec run_routes({[String.t], [String.t]}) :: visits
  defp run_routes({santa_route, robot_route}) do
    merge_routes(run_route(santa_route), run_route(robot_route))
  end

  @spec merge_routes({coordinate, visits}, {coordinate, visits}) :: visits
  defp merge_routes({_, santa_visits}, {_, robot_visits}) do
    Map.merge(santa_visits, robot_visits, fn _k, v1, v2 -> v1 + v2 end)
  end
end
