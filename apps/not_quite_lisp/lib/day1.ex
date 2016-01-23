defmodule Day1 do
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
