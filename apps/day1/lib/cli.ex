defmodule Day1.CLI do
  @moduledoc """
    CLI for day1 problems. Pass a string to get the floor number. Use the --no-basement option to check for
    bad instruction when there is no basement.

    #Examples

    $./day_1
    Enter the text, Santa!

    $./day_1 "(()"
    Go to floor 1

    $./day_1 "())("
    Go to floor 0

    $./day_1 "())(" --no-basement
    Directions required entering a non-existent basement after 3 steps
  """
  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp process({_options, []}) do
    IO.puts "Enter the text, Santa!"
  end
  defp process({[basement: false], text}) do
    text
    |> UnbalancedParen.get_balance
    |> format_basement
    |> IO.puts
  end
  defp process({_options, text}) do
    text
    |> UnbalancedParen.get_degree
    |> format_direction
    |> IO.puts
  end

  defp format_basement({:negative, step}) do
    "Directions required entering a non-existent basement after #{step} steps"
  end
  defp format_basement({_, floor}) do
    format_direction(floor)
  end

  defp format_direction(floor) do
    "Go to floor #{floor}"
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: ["basement": :boolean]) do
      {options, [text], _invalid} -> {options, text}
      {options, [], _invalid} -> {options, []}
    end
  end
end
