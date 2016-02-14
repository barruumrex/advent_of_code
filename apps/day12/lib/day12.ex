defmodule Day12 do
  @moduledoc """
  Helper functions for day 12 of Advent of Code
  """

  @doc """
  Take json string and sum it
  """
  @spec json_sum(String.t) :: integer
  def json_sum(json) do
    json
    |> Poison.decode!()
    |> sum()
  end

  @doc """
  Recursively sum nested data structure ignoring anything that isn't an integer

  ## Examples

      iex> Day12.sum(%{"a": [-1, 1], "b": %{"a": 2, "b": "apple"}})
      2

      iex> Day12.sum(["apple", 1, 2, [3, 4, "banana", %{"a": 5, "b": [6, "coconut"]}]])
      21
  """
  @spec sum(any) :: integer
  def sum(json) when is_list(json), do: json |> Enum.reduce(0, fn(x, acc) -> sum(x) + acc end)
  def sum(x) when is_integer(x), do: x
  def sum(x) when is_binary(x), do: 0
  def sum(json) when is_map(json), do: json |> Map.values() |> sum()

  @doc """
  Take json string and sum it ignoring maps that contain the string "red".
  """
  @spec red_json_sum(String.t) :: integer
  def red_json_sum(json) do
    json
    |> Poison.decode!()
    |> red_sum()
  end

  @doc """
  Recursively sum nested data structure exluding maps that contain the string "red".

  ## Examples

      iex> Day12.red_sum(%{"a": [-1, 1], "b": %{"a": 2, "b": "apple"}})
      2

      iex> Day12.red_sum(["apple", 1, 2, [3, 4, "banana", %{"a": "red", "b": [6, "coconut"]}]])
      10
  """
  @spec red_sum(any) :: integer
  def red_sum(json) when is_list(json), do: json |> Enum.reduce(0, fn(x, acc) -> red_sum(x) + acc end)
  def red_sum(x) when is_integer(x), do: x
  def red_sum(x) when is_binary(x), do: 0
  def red_sum(json) when is_map(json), do: json |> Map.values() |> red_values_sum()

  @spec red_values_sum(list) :: integer
  defp red_values_sum(values) do
    if "red" in values do
      0
    else
      red_sum(values)
    end
  end
end
