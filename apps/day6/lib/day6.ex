defmodule Day6 do
  @moduledoc """
    Helper functions for day6 of Advent of code
  """
  @typedoc """
  Tuple representing length, width, and height
  """
  @type coordinate :: {integer, integer}

  @doc """
  Run all instructions and return number of lights on at the end

  #Examples

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999"])
      1000000

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999", "toggle 0,0 through 999,0"])
      999000
  """
  @spec perform_instructions(list(String.t)) :: integer
  def perform_instructions(instructions) do
    instructions
    |> Enum.reduce(%{}, &perform_instruction/2)
    |> Enum.reduce(0, fn {_key, :on}, acc -> acc + 1
                         {_key, :off}, acc -> acc end)
  end

  @doc """
  Run instruction against a grid of lights

  #Examples

      iex> Day6.perform_instruction("turn on 0,0 through 1,1", %{})
      %{{0, 0} => :on, {0, 1} => :on, {1, 0} => :on, {1, 1} => :on}

      iex> Day6.perform_instruction("toggle 0,0 through 1,1", %{{0, 0} => :on})
      %{{0, 0} => :off, {0, 1} => :on, {1, 0} => :on, {1, 1} => :on}
  """
  @spec perform_instruction(String.t, map) :: map
  def perform_instruction(instruction, lights) do
    {action, [{start_x, start_y}, {end_x, end_y}]} = parse_instruction(instruction)

    changes = for x <- start_x..end_x, y <- start_y..end_y, do: action.({x, y}, lights)
    Map.merge(lights, Map.new(changes))
  end

  @spec parse_instruction(String.t) :: {(coordinate, Map -> {coordinate, :on | :off}), list(coordinate)}
  defp parse_instruction("turn on " <> tail), do: {&on/2, get_coordinates(tail)}
  defp parse_instruction("turn off " <> tail), do: {&off/2, get_coordinates(tail)}
  defp parse_instruction("toggle " <> tail), do: {&toggle/2, get_coordinates(tail)}

  @spec get_coordinates(String.t) :: list(coordinate)
  defp get_coordinates(sentence) do
    sentence
    |> String.split(" through ")
    |> Enum.map(&to_coordinate/1)
  end

  @spec to_coordinate(String.t) :: coordinate
  defp to_coordinate(coordinate) do
    coordinate
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  @spec toggle(coordinate, map) :: {coordinate, :on | :off}
  defp toggle(key, lights) do
    value = lights
      |> Map.get(key, :off)
      |> do_toggle
  {key, value}
  end

  @spec do_toggle(:on | :off) :: :on | :off
  defp do_toggle(:on), do: :off
  defp do_toggle(:off), do: :on

  @spec on(coordinate, map) :: tuple
  defp on(key, _lights), do: {key, :on}

  @spec off(coordinate, map) :: tuple
  defp off(key, _lights), do: {key, :off}
end
