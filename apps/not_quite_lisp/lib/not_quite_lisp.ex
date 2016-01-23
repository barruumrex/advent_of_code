defmodule UnbalancedParen do
  @moduledoc """
    Module for dealing with strings with an unbalanced set of parentheses
  """

  @doc """
  Get the degree of unbalance for the string of parentheses

  #Examples

      iex> UnbalancedParen.degree("(())")
      0

      iex> UnbalancedParen.degree("()()")
      0

      iex> UnbalancedParen.degree("(((")
      3

      iex> UnbalancedParen.degree("(()(()(")
      3

      iex> UnbalancedParen.degree("))(((((")
      3

      iex> UnbalancedParen.degree("())")
      -1

      iex> UnbalancedParen.degree("))(")
      -1

      iex> UnbalancedParen.degree(")))")
      -3

      iex> UnbalancedParen.degree(")())())")
      -3
  """
  @spec degree(String.t) :: integer
  def degree(text) do
    text
    |> String.graphemes
    |> Enum.reduce(0, &shift_balance/2)
  end

  defp shift_balance("(", balance), do: balance + 1
  defp shift_balance(")", balance), do: balance - 1
  defp shift_balance(_letter, balance), do: balance
end
