defmodule Day4.CLI do
  @moduledoc """
    CLI for day4 problems.
  """
  def main(args) do
    args
    |> parse_args
    |> process
    |> format
    |> IO.puts
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: []) do
      {options, [filename], _} -> {:ok, filename, options}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end

  defp process({:error, reason}), do: reason
  defp process({:ok, filename, _options}) do
    filename
    |> File.read!
    |> String.strip
    |> find_5_and_6
  end

  defp find_5_and_6(text) do
    {Day4.find_coin(text,5), Day4.find_coin(text,6)}
  end

  defp format({solution5, solution6}) do
    "Solution with five zeroes is #{solution5}.\nSolution with six zeroes is #{solution6}"
  end
  defp format(reason) do
    reason
  end
end
