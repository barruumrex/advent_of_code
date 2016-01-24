defmodule Day4 do
  @moduledoc """
    Helper functions for day4 of Advent of code
  """

  @doc """
  Find first advent coin that starts with the given string

  #Examples

      iex> Day4.find_coin("abcdef", 5)
      609043

      iex> Day4.find_coin("pqrstuv", 5)
      1048970
  """
  @spec find_coin(String.t, integer) :: integer
  def find_coin(text, zeroes) do
    0
    |> Stream.iterate(&(&1 + 1))
    |> check_coins(text, fn(x) -> create_validator(zeroes).(x) end)
  end

  @spec check_coins([integer], String.t, fun) :: integer
  defp check_coins(candidates, text, validator) do
    candidates
    |> Enum.find(fn(x) -> check_coin(text <> to_string(x), validator) end)
  end

  @spec check_coin(String.t, fun) :: boolean
  defp check_coin(candidate, validator) do
    candidate
    |> create_coin
    |> validator.()
  end

  @spec create_coin(String.t) :: binary
  defp create_coin(candidate), do: :crypto.hash(:md5, candidate)

  @spec create_validator(integer) :: fun
  defp create_validator(zeroes) do
    prefix_size = zeroes * 4
    fn
      <<0::size(prefix_size), _::bits>> -> true
      _ -> false
    end
  end
end
