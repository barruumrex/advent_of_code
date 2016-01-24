defmodule Day4.CLI do
  @moduledoc """
    CLI for day4 problems.
  """
  def main(args) do
    args
    |> parse_args
    |> process
    |> format
  end

  defp process({:error, reason}), do: IO.puts reason
  defp process({:ok, filename, options}) do
    filename
    |> File.read!
    |> String.strip
  end

  defp parse_args(args) do
    case OptionParser.parse(args, strict: []) do
      {options, [filename], _} -> {:ok, filename, options}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end
end
