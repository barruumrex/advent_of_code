defmodule Day6 do
  @moduledoc """
  Helper functions for day6 of Advent of code
  """
  @typedoc """
  Tuple representing x and y coordinates
  """
  @type coordinate :: {non_neg_integer, non_neg_integer}

  @typedoc """
  Tuple representing a light
  """
  @type light :: {coordinate, non_neg_integer}

  @typedoc """
  Map representing the light field
  """
  @type light_field :: %{coordinate: non_neg_integer}

  @doc """
  Run all instructions and return number of lights on at the end

  ## Examples

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999"], :part1)
      1000000

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999", "toggle 0,0 through 999,0"], :part1)
      999000

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999"], :part2)
      1000000

      iex> Day6.perform_instructions(["turn on 0,0 through 999,999", "toggle 0,0 through 999,0"], :part2)
      1002000
  """
  @spec perform_instructions(list(String.t), :part1 | :part2) :: non_neg_integer
  def perform_instructions(instructions, mode) do
    instructions
    |> Enum.reduce(%{}, &(perform_instruction(&1, &2, mode)))
    |> Enum.reduce(0, fn {_key, val}, acc -> acc + val end)
  end

  @doc """
  Run instruction against a grid of lights

  ## Examples

      iex> Day6.perform_instruction("turn on 0,0 through 1,1", %{}, :part1)
      %{{0, 0} => 1, {0, 1} => 1, {1, 0} => 1, {1, 1} => 1}

      iex> Day6.perform_instruction("toggle 0,0 through 1,1", %{{0, 0} => 1}, :part1)
      %{{0, 0} => 0, {0, 1} => 1, {1, 0} => 1, {1, 1} => 1}

      iex> Day6.perform_instruction("turn on 0,0 through 1,1", %{}, :part2)
      %{{0, 0} => 1, {0, 1} => 1, {1, 0} => 1, {1, 1} => 1}

      iex> Day6.perform_instruction("toggle 0,0 through 1,1", %{{0, 0} => 1}, :part2)
      %{{0, 0} => 3, {0, 1} => 2, {1, 0} => 2, {1, 1} => 2}

      iex> Day6.perform_instruction("turn off 0,0 through 1,1", %{{0, 0} => 1}, :part2)
      %{{0, 0} => 0, {0, 1} => 0, {1, 0} => 0, {1, 1} => 0}
  """
  @spec perform_instruction(String.t, light_field, :part1 | :part2) :: light_field
  def perform_instruction(instruction, lights, mode) do
    instruction
    |> parse_instruction(mode)
    |> get_changeset(lights)
    |> merge_changeset(lights)
  end

  @spec get_changeset({(coordinate, light_field -> light), list(coordinate)}, light_field) :: light_field
  defp get_changeset({action, [{start_x, start_y}, {end_x, end_y}]}, lights) do
    for x <- start_x..end_x, y <- start_y..end_y, into: %{}, do: action.({x, y}, lights)
  end

  @spec merge_changeset(light_field, light_field) :: light_field
  defp merge_changeset(changeset, lights), do: Map.merge(lights, changeset)

  @spec parse_instruction(String.t, :part1 | :part2) :: {(coordinate, light_field -> light), list(coordinate)}
  defp parse_instruction("turn on " <> tail, :part1), do: {&on/2, get_coordinates(tail)}
  defp parse_instruction("turn off " <> tail, :part1), do: {&off/2, get_coordinates(tail)}
  defp parse_instruction("toggle " <> tail, :part1), do: {&toggle/2, get_coordinates(tail)}
  defp parse_instruction("turn on " <> tail, :part2), do: {&increment/2, get_coordinates(tail)}
  defp parse_instruction("turn off " <> tail, :part2), do: {&decrement/2, get_coordinates(tail)}
  defp parse_instruction("toggle " <> tail, :part2), do: {&two_step/2, get_coordinates(tail)}

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

  @spec toggle(coordinate, light_field) :: {coordinate, 1 | 0}
  defp toggle(key, lights) do
    value = lights
      |> Map.get(key, 0)
      |> do_toggle
    {key, value}
  end

  @spec do_toggle(1 | 0) :: 1 | 0
  defp do_toggle(1), do: 0
  defp do_toggle(0), do: 1

  @spec on(coordinate, light_field) :: {coordinate, 1}
  defp on(key, _lights), do: {key, 1}

  @spec off(coordinate, light_field) :: {coordinate, 0}
  defp off(key, _lights), do: {key, 0}

  @spec increment(coordinate, light_field) :: light
  defp increment(key, lights) do
    {key, apply_change(key, lights, &(&1 + 1)) }
  end

  @spec decrement(coordinate, light_field) :: light
  defp decrement(key, lights) do
    {key, apply_change(key, lights, &(if &1 == 0, do: 0, else: &1 - 1)) }
  end

  @spec two_step(coordinate, light_field) :: light
  defp two_step(key, lights) do
    {key, apply_change(key, lights, &(&1 + 2)) }
  end

  @spec apply_change(coordinate, light_field, (non_neg_integer -> non_neg_integer)) :: non_neg_integer
  defp apply_change(key, lights, change) do
    lights
    |> Map.get(key, 0)
    |> change.()
  end
end
