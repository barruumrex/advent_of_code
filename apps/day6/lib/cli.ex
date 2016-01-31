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
  defp process({:ok, filename}) do
    filename
    |> File.read!
    |> String.split("\n", trim: true)
    |> Day6.perform_instructions
    |> format
  end

  defp format(results) do
    "#{results} lights remain lit"
  end

  defp output_response(text) do
    IO.puts "#{text}"
  end

  defp parse_args(args) do
    case OptionParser.parse(args) do
      {_, [filename], _} -> {:ok, filename}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end
end
