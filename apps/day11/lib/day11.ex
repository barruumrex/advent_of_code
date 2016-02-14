defmodule Day11 do
  @moduledoc """
  Helper functions for Day11 of Advent of Code
  """

  @doc """
  Increment char string to the next value

  ## Examples

      iex> Day11.increment('xy')
      'xz'

      iex> Day11.increment('xz')
      'ya'
  """
  @spec increment(char_list) :: char_list
  def increment(current) do
    current
    |> Enum.reverse()
    |> do_increment()
    |> Enum.reverse()
  end

  @spec do_increment(char_list) :: char_list
  defp do_increment([]), do: []
  defp do_increment([?z | rest]), do: [?a | do_increment(rest)]
  defp do_increment([char | rest]), do: [char + 1 | rest]


end
