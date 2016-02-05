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
      |> String.length()
  end

  @doc """
  Escaped length minus memory length of a string

  ## Examples

      iex> Day8.escape_diff(~S(""))
      4

      iex> Day8.escape_diff(~S("abc"))
      4

      iex> Day8.escape_diff(~S("aaa\\"aaa"))
      6

      iex> Day8.escape_diff(~S("\\x27"))
      5
  """
  @spec escape_diff(String.t) :: non_neg_integer
  def escape_diff(line) do
    escape_length(line) - String.length(line)
  end

  @spec escape_length(String.t) :: non_neg_integer
  def escape_length(line) do
    line
    |> escape_string()
    |> String.length()
  end

  @spec escape_string(String.t) :: String.t
  defp escape_string(line) do
    line
    |> String.codepoints()
    |> Enum.reduce(~S(""), fn(x,acc) -> acc <> escape_char(x) end)
  end

  @spec escape_char(String.t) :: String.t
  defp escape_char("\""), do: ~S(\")
  defp escape_char("\\"), do: ~S(\\)
  defp escape_char(x), do: x

end
