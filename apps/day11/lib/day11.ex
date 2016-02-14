defmodule Day11 do
  @moduledoc """
  Helper functions for Day11 of Advent of Code
  """

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
    |> increment()
    |> Stream.unfold(fn x -> {x, increment(x)} end)
    |> Enum.find(fn x -> contains_straight?(x) and contains_pairs?(x) and not contains_forbidden?(x) end)
    |> to_string()
  end

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
