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
  Determines if a string is nice according to the year 2 rules

  #Examples

      iex> Day5.super_nice?("qjhvhtzxzqqjkmpb")
      true

      iex> Day5.super_nice?("xxyxx")
      true

      iex> Day5.super_nice?("uurcxstgmygtbstg")
      false

      iex> Day5.super_nice?("ieodomkazucvgmuy")
      false
  """
  @spec super_nice?(String.t) :: boolean
  def super_nice?(text) do
    repeated_tuple?(text) && contains_spaced_dup?(text)
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
    |> Enum.chunk(2, 1)
    |> has_duplicate?
  end

  @doc """
  Checks if Enumerable contains any duplicate members

  #Examples

      iex> Day5.has_duplicate?(["a", 1, 3, "a"])
      true

      iex> Day5.has_duplicate?([1, 2, 3, 4])
      false
  """
  @spec has_duplicate?(Enumerable.t) :: boolean
  def has_duplicate?(members), do: do_has_duplicate?(members, false)

  @spec do_has_duplicate?(Enumerable.t, boolean) :: boolean
  defp do_has_duplicate?(_, true), do: true
  defp do_has_duplicate?([], false), do: false
  defp do_has_duplicate?([first | rest], false), do: do_has_duplicate?(rest, Enum.member?(rest, first))


  @spec tuple_within?([String.t]) :: boolean
  defp tuple_within?([first | rest]), do: do_tuple_within?(false, first, rest)

  @doc """
  Checks if a character repeats with a single character between the repetition

  #Examples
  #Examples

      iex> Day5.contains_spaced_dup?("qjhvhtzxzqqjkmpb")
      true

      iex> Day5.contains_spaced_dup?("xxyxx")
      true

      iex> Day5.contains_spaced_dup?("uurcxstgmygtbstg")
      false

      iex> Day5.contains_spaced_dup?("ieodomkazucvgmuy")
      true
  """
  @spec contains_spaced_dup?(String.t) :: boolean
  def contains_spaced_dup?(text) do
    text
    |> String.graphemes
    |> do_contains_spaced_dup?
  end

  @spec do_contains_spaced_dup?([String.t]) :: boolean
  defp do_contains_spaced_dup?([x, _, x | _tail]), do: true
  defp do_contains_spaced_dup?(tail) when length(tail) < 4, do: false
  defp do_contains_spaced_dup?([_head | tail]), do: do_contains_spaced_dup?(tail)

end
