defmodule Day1 do
  def main(args) do
    args
    |> parse_args
    |> process
  end

  def process([]) do
    IO.puts "Enter the text, Santa!"
  end

  def process(text) do
    text
    |> UnbalancedParen.degree
    |> format_response
    |> IO.puts
  end

  defp format_response(floor) do
    "Go to floor #{floor}"
  end

  defp parse_args(args) do
    {_options, [text], _invalid} = OptionParser.parse(args)
    text
  end
end
