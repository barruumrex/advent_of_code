defmodule Day2 do
  @moduledoc """
    Helper functions for day2 of Advent of code
  """

  @doc """
    Takes a string representation of a box and returns the amount of necessary wrapping paper

    #Examples

        iex> Day2.get_paper_amount("2x3x4")
        58

        iex> Day2.get_paper_amount("1x1x10")
        43
  """
  @spec get_paper_amount(String.t) :: integer
  def get_paper_amount(text) do
    text
    |> get_dimensions
    |> get_sides
    |> get_total
  end

  @spec get_dimensions(String.t) :: {integer, integer, integer}
  defp get_dimensions(text) do
    text
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  @spec get_sides({integer, integer, integer}) :: {integer, integer, integer}
  defp get_sides({l, w, h}), do: {l*w, w*h, h*l}

  @spec get_total({integer, integer, integer}) :: integer
  defp get_total({a, b, c}), do: 2*a + 2*b + 2*c + Enum.min([a, b, c])
end
