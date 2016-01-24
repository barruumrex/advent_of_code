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
    |> Enum.reduce({0, 0}, &process_line/2)
    |> output_response
  end

  defp process_line(text, acc) do
    text
    |> String.strip
    |> get_paper_and_ribbon
    |> add_to(acc)
  end

  defp get_paper_and_ribbon(text) do
    {Day2.get_paper_amount(text), Day2.get_ribbon_amount(text)}
  end

  defp add_to({new_paper, new_ribbon}, {total_paper, total_ribbon}) do
    {new_paper + total_paper, new_ribbon + total_ribbon}
  end

  defp output_response({paper, ribbon}) do
    IO.puts "The elves need #{paper} square feet of wrapping paper"
    IO.puts "The elves need #{ribbon} feet of ribbon"
  end

  defp parse_args(args) do
    case OptionParser.parse(args) do
      {_, [filename], _} -> {:ok, filename}
      {_, [], _} -> {:error, "Please specify a file"}
    end
  end
end
