defmodule Day5 do
  @moduledoc """
    Helper functions for day5 of Advent of code
  """

  @vowels "aeiou"
  @forbidden ["ab","cd","pq","xy"]

  @doc """
  Determines if a string is nice

  #Examples
      iex> Day5.is_nice?("ugknbfddgicrmopn")
      true

      iex> Day5.is_nice?("aaa")
      true

      iex> Day5.is_nice?("jchzalrnumimnmhp")
      false

      iex> Day5.is_nice?("haegwjzuvuyypxyu")
      false

      iex> Day5.is_nice?("dvszwmarrgswjxmb")
      false
  """
  @spec is_nice?(String.t) :: boolean
  def is_nice?(text) do
    three_vowels?(text) && contains_dups?(text) && !contains_forbidden?(text)
  end

  @doc """
  Checks if text has three vowels

  #Examples

      iex> Day5.three_vowels?("ugknbfddgicrmopn")
      true

      iex> Day5.three_vowels?("aaa")
      true

      iex> Day5.three_vowels?("dvszwmarrgswjxmb")
      false
  """
  @spec three_vowels?(String.t) :: boolean
  def three_vowels?(text) do
    text
    |> String.graphemes
    |> three_vowels_within?
  end

  @spec three_vowels_within?([String.t]) :: boolean
  defp three_vowels_within?(letters), do: do_three_vowels_within?(letters, 0)

  @spec do_three_vowels_within?([String.t], 0..3) :: boolean
  defp do_three_vowels_within?(_letters, 3), do: true
  defp do_three_vowels_within?([], _matches), do: false
  defp do_three_vowels_within?([letter | tail], matches) do
    if(String.contains?(@vowels, letter)) do
      do_three_vowels_within?(tail, matches + 1)
    else
      do_three_vowels_within?(tail, matches)
    end
  end

  @doc """
  Checks if text contains adjacent duplicate letter

  #Examples

      iex> Day5.contains_dups?("ugknbfddgicrmopn")
      true

      iex> Day5.contains_dups?("aaa")
      true

      iex> Day5.contains_dups?("jchzalrnumimnmhp")
      false
  """
  @spec contains_dups?(String.t) :: boolean
  def contains_dups?(text) do
    text
    |> String.graphemes
    |> dup_within?
  end

  @spec dup_within?([String.t]) :: boolean
  defp dup_within?([]), do: false
  defp dup_within?([letter | tail]) when letter == hd(tail), do: true
  defp dup_within?([_letter | tail]), do: dup_within?(tail)

  @doc """
  Checks if text contains forbidden sequences

  #Examples

      iex> Day5.contains_forbidden?("ugknbfddgicrmopn")
      false

      iex> Day5.contains_forbidden?("aaa")
      false

      iex> Day5.contains_forbidden?("haegwjzuvuyypxyu")
      true
  """
  @spec contains_forbidden?(String.t) :: boolean
  def contains_forbidden?(text) do
    text
    |> String.contains?(@forbidden)
  end

  @doc """
  Checks if text contains any repeated non-overlapping tuples

  #Examples

      iex> Day5.repeated_tuple?("qjhvhtzxzqqjkmpb")
      true

      iex> Day5.repeated_tuple?("xxyxx")
      true

      iex> Day5.repeated_tuple?("uurcxstgmygtbstg")
      true

      iex> Day5.repeated_tuple?("ieodomkazucvgmuy")
      false
  """
  @spec repeated_tuple?(String.t) :: boolean
  def repeated_tuple?(text) do
    text
    |> String.graphemes
    |> tuple_within?
  end

  @spec tuple_within?([String.t]) :: boolean
  defp tuple_within?([first | rest]), do: do_tuple_within?(first, rest)

  @spec do_tuple_within?(String.t, [String.t]) :: boolean
  defp do_tuple_within?(_first, rest) when length(rest) < 3, do: false
  defp do_tuple_within?(first, [second | rest]) do
    tuple = first <> second
    text = Enum.join(rest)
    if String.contains?(text, tuple) do
      true
    else
      do_tuple_within?(second, rest)
    end
  end

end
