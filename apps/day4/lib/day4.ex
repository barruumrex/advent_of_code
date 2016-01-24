defmodule Day4 do
  @moduledoc """
    Helper functions for day4 of Advent of code
  """

  @doc """
  Find first advent coin that starts with the given string

  #Examples

      iex> Day4.find_coin("abcdef")
      609043

      iex> Day4.find_coin("pqrstuv")
      1048970
  """
  @spec find_coin(String.t) :: integer
  def find_coin(text) do
    0
    |> Stream.iterate(&(&1 + 1))
    |> Enum.find(fn(x) -> check_coin(text <> to_string(x)) end)
  end

  @spec check_coin(String.t) :: boolean
  defp check_coin(candidate) do
    candidate
    |> create_coin
    |> is_coin?
  end

  @spec create_coin(String.t) :: binary
  defp create_coin(candidate), do: :crypto.hash(:md5, candidate)

  @spec is_coin?(binary) :: boolean
  defp is_coin?(<<0::size(20), _::bits>>), do: true
  defp is_coin?(_), do: false
end
