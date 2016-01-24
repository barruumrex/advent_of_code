defmodule UnbalancedParen do
  @moduledoc """
    Module for dealing with strings with an unbalanced set of parentheses
  """

  @doc """
  Get the degree of unbalance for the string of parentheses

  #Examples

      iex> UnbalancedParen.get_degree("(())")
      0

      iex> UnbalancedParen.get_degree("()()")
      0

      iex> UnbalancedParen.get_degree("(((")
      3

      iex> UnbalancedParen.get_degree("(()(()(")
      3

      iex> UnbalancedParen.get_degree("))(((((")
      3

      iex> UnbalancedParen.get_degree("())")
      -1

      iex> UnbalancedParen.get_degree("))(")
      -1

      iex> UnbalancedParen.get_degree(")))")
      -3

      iex> UnbalancedParen.get_degree(")())())")
      -3
  """
  @spec get_degree(String.t) :: integer
  def get_degree(text) do
    text
    |> String.graphemes
    |> Enum.reduce(0, &shift_balance/2)
  end

  @doc """
  Get the balance for the string of parentheses, failing fast if degree ever goes negative. If the result
  is a negative balance, the failure location will be returned. Otherwise the degree will be returned.

      iex> UnbalancedParen.get_balance(")")
      {:negative, 1}

      iex> UnbalancedParen.get_balance("()())")
      {:negative, 5}

      iex> UnbalancedParen.get_balance("()(")
      {:positive, 1}

      iex> UnbalancedParen.get_balance("(()())")
      {:balanced, 0}
  """
  @spec get_balance(String.t) :: {:balanced, 0} | {:negative, integer} | {:positive, integer}
  def get_balance(text) do
    text
    |> String.graphemes
    |> Enum.reduce_while({0,0}, &fast_fail_shift_balance/2)
    |> is_balanced?
  end

  @spec fast_fail_shift_balance(String.t, {integer, integer}) :: {atom, {integer, integer}}
  defp fast_fail_shift_balance(_, {-1, location}), do: {:halt, {-1, location}}
  defp fast_fail_shift_balance("(", {balance, location}), do: {:cont, {balance + 1, location + 1}}
  defp fast_fail_shift_balance(")", {balance, location}), do: {:cont, {balance - 1, location + 1}}
  defp fast_fail_shift_balance(_, {balance, location}), do: {:cont, {balance, location + 1}}

  @spec is_balanced?({integer, integer}) :: {:balanced, 0} | {:negative, integer} | {:positive, integer}
  defp is_balanced?({-1, location}), do: {:negative, location}
  defp is_balanced?({balance, _location}) when balance > 0, do: {:positive, balance}
  defp is_balanced?(_), do: {:balanced, 0}

  @spec shift_balance(String.t, integer) :: integer
  defp shift_balance("(", balance), do: balance + 1
  defp shift_balance(")", balance), do: balance - 1
  defp shift_balance(_letter, balance), do: balance
end
