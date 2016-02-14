defmodule Runner do
  @moduledoc """
  Helper methods printing results of script
  """

  @doc """
  Print result of script
  """
  @spec print_result(String.t) :: String.t
  def print_result(result) do
    IO.puts("The result is #{result}.")
    result
  end
end

"lib/input.txt"
|> File.read!()
|> Day12.json_sum()
|> Runner.print_result()
