defmodule Day5 do
  @moduledoc """
    Helper functions for day5 of Advent of code
  """

  @vowels "aeiou"
  @forbidden ["ab","cd","pq","xy"]

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

  @spec do_three_vowels_within?([String.t], integer) :: boolean
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
end
