defmodule Day5.CLI do
  @moduledoc """
    CLI for day5 problems.
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
    |> File.stream!
    |> Enum.reduce({0, 0}, &process_line/2)
  end

  defp process_line(text, acc) do
    text
    |> String.strip
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
