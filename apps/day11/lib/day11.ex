defmodule Day11 do
  @moduledoc """
  Helper functions for Day11 of Advent of Code
  """

  @forbidden [?i, ?o, ?l]
  @first_valid_char ?a..?z |> Enum.find(&(not Enum.member?(@forbidden, &1)))

  @doc """
  Return the next valid password according to Santa's insane rules

  ## Examples

      iex> Day11.next_password("abcdefgh")
      "abcdffaa"

      iex> Day11.next_password("ghijklmn")
      "ghjaabcc"
  """
  @spec next_password(String.t) :: String.t
  def next_password(current) do
    current
    |> String.to_char_list()
    |> increment() #Current password is never valid. Increment once.
    |> remove_forbidden()
    |> Stream.unfold(fn x -> {x, increment(x)} end)
    |> Enum.find(&valid_password?/1)
    |> to_string()
  end

  @doc """
  Increment char list to the next value, skipping forbidden characters.

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
  defp do_increment([?z | rest]), do: [increment_char(?z) | do_increment(rest)]
  defp do_increment([char | rest]), do: [increment_char(char) | rest]

  @spec increment_char(char) :: char
  defp increment_char(char), do: do_increment_char(char, false)

  @spec do_increment_char(char, boolean) :: char
  defp do_increment_char(char, true), do: char
  defp do_increment_char(?z, false), do: do_increment_char(?a, not Enum.member?(@forbidden, ?a))
  defp do_increment_char(char, false), do: do_increment_char(char + 1, not Enum.member?(@forbidden, char + 1))

  @doc """
  Increment char_list to next valid state.

  Increment first forbidden character and set all subsequent characters to the first
  non forbidden character.
  ## Examples

      iex> Day11.remove_forbidden('abcdefgh')
      'abcdefgh'

      iex> Day11.remove_forbidden('abicodlb')
      'abjaaaaa'
  """
  @spec remove_forbidden(char_list) :: char_list
  def remove_forbidden([]), do: []
  def remove_forbidden([char | rest]) when char in @forbidden do
    [increment_char(char) | List.duplicate(@first_valid_char, length(rest))]
  end
  def remove_forbidden([char | rest]), do: [char | remove_forbidden(rest)]

  @spec valid_password?(char_list) :: boolean
  defp valid_password?(chars), do: contains_straight?(chars) and contains_pairs?(chars)

  @doc """
  Find if char_list contains an incrementing straight.

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
  Find if char_list contains two pairs

  ## Examples

      iex> Day11.contains_pairs?('hijklmmn')
      false

      iex> Day11.contains_pairs?('abbceffg')
      true
  """
  @spec contains_pairs?(char_list) :: boolean
  def contains_pairs?(chars), do: do_contains_pairs?(chars, 0)

  @spec do_contains_pairs?(char_list, non_neg_integer) :: boolean
  defp do_contains_pairs?(_, 2), do: true
  defp do_contains_pairs?([], _), do: false
  defp do_contains_pairs?([x, x | rest], count), do: do_contains_pairs?(rest, count + 1)
  defp do_contains_pairs?([_ | rest], count), do: do_contains_pairs?(rest, count)
end
