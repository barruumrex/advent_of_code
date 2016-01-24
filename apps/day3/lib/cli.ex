defmodule Day3.CLI do
  @moduledoc """
    CLI for day3 problems.
  """
  def main(args) do
    args
    |> parse_args
    |> process
    |> IO.inspect
  end

  defp process({:error, reason}), do: IO.puts reason
  defp process({:ok, filename, options}) do
    filename
    |> File.read!
    |> String.strip
    |> deliver(options)
  end

  defp deliver(directions, [robot: true]), do: Day3.robo_deliveries(directions)
  defp deliver(directions, _), do: Day3.make_deliveries(directions)

  defp parse_args(args) do
    case OptionParser.parse(args, strict: ["robot": :boolean]) do
      {options, [filename], _} -> {:ok, filename, options}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end
end
