defmodule Day7 do
  use Bitwise
  @moduledoc """
  Helper functions for Day7 of Advent of Code
  """

  @doc """
  Executes Day7 circuit commands of the form ["123", "->", "x"]

  ## Examples
      iex> Day7.run_command(["123", "->", "x"], %{})
      %{"x" => 123}

      iex> Day7.run_command(["x", "AND", "y", "->", "d"], %{"x" => 123, "y" => 456})
      %{"x" => 123, "y" => 456, "d" => 72}

      iex> Day7.run_command(["x", "OR", "y", "->", "e"], %{"x" => 123, "y" => 456})
      %{"x" => 123, "y" => 456, "e" => 507}

      iex> Day7.run_command(["x", "LSHIFT", "2", "->", "f"], %{"x" => 123, "y" => 456})
      %{"x" => 123, "y" => 456, "f" => 492}

      iex> Day7.run_command(["y", "RSHIFT", "2", "->", "g"], %{"x" => 123, "y" => 456})
      %{"x" => 123, "y" => 456, "g" => 114}

      iex> Day7.run_command(["NOT", "x", "->", "h"], %{"x" => 123, "y" => 456})
      %{"x" => 123, "y" => 456, "h" => 65412}
  """
  @spec run_command(list(String.t), %{String.t => non_neg_integer}) :: %{String.t => non_neg_integer}
  def run_command([val, "->", key], results), do: Map.put(results, key, val |> Integer.parse |> elem(0))
  def run_command([left, "AND", right, "->", key], results) do
    Map.put(results, key, Map.get(results, left) &&& Map.get(results, right))
  end
  def run_command([left, "OR", right, "->", key], results) do
    Map.put(results, key, Map.get(results, left) ||| Map.get(results, right))
  end
  def run_command([left, "LSHIFT", right, "->", key], results) do
    Map.put(results, key, Map.get(results, left) <<< (right |> Integer.parse |> elem(0)))
  end
  def run_command([left, "RSHIFT", right, "->", key], results) do
    Map.put(results, key, Map.get(results, left) >>> (right |> Integer.parse |> elem(0)))
  end
  def run_command(["NOT", left, "->", key], results) do
    Map.put(results, key, results |> Map.get(left) |> bxor(0b1111111111111111))
  end
end
