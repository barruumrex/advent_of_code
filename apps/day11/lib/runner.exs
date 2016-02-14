defmodule Runner do
  @moduledoc """
  Helper methods printing results of script
  """

  @doc """
  Print result of script
  """
  @spec print_result(String.t) :: String.t
  def print_result(password) do
    IO.puts("Next password is #{password}.")
    password
  end
end

"hepxcrrq"
|> Day11.next_password()
|> Runner.print_result()
|> Day11.next_password()
|> Runner.print_result()
