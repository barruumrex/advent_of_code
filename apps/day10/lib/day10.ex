defmodule Day10 do
  @moduledoc """
  Helper functions for Day10 of Advent of Code
  """

  def loop_and_say(num, iterations) when is_integer(num), do: num |> to_string() |> loop_and_say(iterations)

  def loop_and_say(num, 0), do: String.length(num)
  def loop_and_say(num, iterations), do: num |> look_and_say |> loop_and_say(iterations - 1)

  def look_and_say(number) do
    number
    |> look()
    |> say()
  end

  defp look(number) do
    number
    |> collect_dups()
  end

  defp collect_dups(number), do: number |> String.codepoints() |> do_collect_dups()

  defp do_collect_dups([]), do: []
  defp do_collect_dups([{head, count}, head | tail]), do: do_collect_dups([{head, count + 1} | tail])
  defp do_collect_dups([head | tail]) when is_tuple(head), do: [head] ++ do_collect_dups(tail)
  defp do_collect_dups([head | tail]), do: do_collect_dups([{head, 1} | tail])

  defp say(dups) do
    dups
    |> Enum.map(fn({el, count}) -> to_string(count) <> el end)
    |> Enum.join()
  end
end
