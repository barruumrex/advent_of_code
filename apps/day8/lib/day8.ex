defmodule Day8 do
  @moduledoc """
  Helper functions for Day8 of Advent of Code
  """

  @doc """
  Memory length minus literal length of a string

  ## Examples

      iex> Day8.memory_diff(~S(""))
      2

      iex> Day8.memory_diff(~S("abc"))
      2

      iex> Day8.memory_diff(~S("aaa\\"aaa"))
      3

      iex> Day8.memory_diff(~S("\\x27"))
      5
  """
  @spec memory_diff(String.t) :: non_neg_integer
  def memory_diff(line) do
    String.length(line) - literal_length(line)
  end

  @spec literal_length(String.t) :: non_neg_integer
  defp literal_length(line) do
    memory_length = line
      |> Code.eval_string()
      |> elem(0)
      |> String.length
  end
end
