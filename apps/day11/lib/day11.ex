defmodule Day11 do
  @moduledoc """
  Helper functions for Day11 of Advent of Code
  """

  @doc """
  Increment 8 char string to the next value
  """
  @spec increment(String.t) :: String.t
  def increment(current) when byte_size(current) != 8, do: raise ArgumentError
  def increment(current) do
    current
    |> String.to_char_list()
    |> Enum.reverse()
    |> do_increment()
    |> Enum.reverse()
    |> to_string()
  end

  @spec do_increment(char_list) :: char_list
  defp do_increment([]), do: []
  defp do_increment([?z | rest]), do: [?a | do_increment(rest)]
  defp do_increment([char | rest]), do: [char + 1 | rest]
end
