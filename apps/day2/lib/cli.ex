defmodule Day2.CLI do
  @moduledoc """
    CLI for day2 problems.
  """
  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp process({:error, reason}), do: IO.puts reason
  defp process({:ok, filename}) do
    filename
    |> File.stream!
    |> Enum.reduce(0, fn(line, acc) -> acc + (line |> String.strip |> Day2.get_paper_amount) end)
    |> IO.puts
  end

  defp parse_args(args) do
    case OptionParser.parse(args) do
      {_, [filename], _} -> {:ok, filename}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end
end
