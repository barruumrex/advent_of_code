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

  @doc """
  Find if char_list contains an incrementing straight

  ## Examples

      iex> Day11.contains_straight?('hijklmmn')
      true

      iex> Day11.contains_straight?('abbceffg')
      false
  """
  @spec contains_straight?(char_list) :: boolean
  def contains_straight?(chars) do
    chars
    |> Enum.chunk(3, 1)
    |> find_straight()
  end

  @spec find_straight(char_list) :: boolean
  defp find_straight([]), do: false
  defp find_straight([[x, y, z] | _rest]) when y == (x + 1) and z == (x + 2), do: true
  defp find_straight([_ | rest]), do: find_straight(rest)

  @doc """
  Find if char_list contains any forbbiden chars, 'i' 'o' 'l'

  ## Examples

      iex> Day11.contains_forbidden?('hijklmmn')
      true

      iex> Day11.contains_forbidden?('abbceffg')
      false
  """
  @spec contains_forbidden?(char_list) :: boolean
  def contains_forbidden?(chars), do: chars |> Enum.any?(&Enum.member?('iol', &1))
end
