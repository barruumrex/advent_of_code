defmodule Day6.CLI do
  @moduledoc """
    CLI for day6 problems.
  """
  def main(args) do
    args
    |> parse_args
    |> process
    |> output_response
  end

  defp process({:error, reason}), do: reason
  defp process({:ok, filename, options}) do
    filename
    |> File.read!
    |> String.split("\n", trim: true)
    |> perform(options)
    |> format(options)
  end

  defp perform(instructions, [part1: true]), do: Day6.perform_instructions(instructions, :part1)
  defp perform(instructions, [part2: true]), do: Day6.perform_instructions(instructions, :part2)

  defp format(results, [part1: true]), do: "#{results} lights remain lit"
  defp format(results, [part2: true]), do: "#{results} total brightness"


  defp output_response(text) do
    IO.puts "#{text}"
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: ["part1": :boolean, "part2": :boolean]) do
      {_, [], _} -> {:error, "Please specify a file"}
      {[], _, _} -> {:error, "Please specify --part1 or --part2"}
      {options, _, _} when length(options) > 1 -> {:error, "Please specify only --part1 or --part2"}
      {options, [filename], _} -> {:ok, filename, options}
    end
  end
end
