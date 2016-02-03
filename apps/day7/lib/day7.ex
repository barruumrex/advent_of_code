defmodule Day7 do
  use Bitwise
  @moduledoc """
  Helper functions for Day7 of Advent of Code
  """

  @typedoc """
  Map representing a completed circuit
  """
  @type circuit :: %{String.t => non_neg_integer}

  @doc """
  Runs a full Day7 circuit
  """
  @spec run_circuit(list(String.t)) :: circuit
  def run_circuit(wires) do
    wires
    |> setup_gates
    |> eval_gates
  end

  @spec setup_gates(list(String.t)) :: %{String.t => (circuit -> non_neg_integer)}
  defp setup_gates(wires) do
    Enum.reduce(wires, %{}, fn(wire, acc) -> wire |> String.split() |> create_gate(acc) end)
  end

  @doc false
  @spec create_gate(list(String.t), circuit) :: %{String.t => (circuit -> non_neg_integer)}
  def create_gate([left, "AND", right, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      left_wire = get_wire(left, wires)
      right_wire = get_wire(right, wires)
      left_wire &&& right_wire
    end)
  end
  def create_gate([left, "OR", right, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      left_wire = get_wire(left, wires)
      right_wire = get_wire(right, wires)
      left_wire ||| right_wire
    end)
  end
  def create_gate([left, "LSHIFT", right, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      wire = get_wire(left, wires)
      shift = right |> Integer.parse() |> elem(0)
      bsl(wire, shift)
    end)
  end
  def create_gate([left, "RSHIFT", right, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      wire = get_wire(left, wires)
      shift = right |> Integer.parse() |> elem(0)
      bsr(wire, shift)
    end)
  end
  def create_gate(["NOT", left, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      wire = get_wire(left, wires)
      bxor(wire, 0b1111111111111111)
    end)
  end
  def create_gate([val, "->", key], results) do
    Map.put(results, key, fn(wires) ->
      get_wire(val, wires)
    end)
  end

  @spec get_wire(String.t, circuit) :: non_neg_integer
  defp get_wire(signal, wires) do
    case Integer.parse(signal) do
      :error -> Map.fetch!(wires, signal)
      {value, _} -> value
    end
  end

  @spec eval_gates(%{String.t => (circuit -> non_neg_integer)}) :: circuit
  defp eval_gates(potentials), do: do_eval_gates(potentials, %{})

  @spec do_eval_gates(%{String.t => (circuit -> non_neg_integer)}, circuit) :: circuit
  defp do_eval_gates(potentials, evaluated) when map_size(potentials) == 0, do: evaluated
  defp do_eval_gates(potentials, evaluated) do
    new_evaluated = Enum.reduce(potentials, evaluated, &eval_gate/2)
    new_potentials = Map.drop(potentials, Map.keys(new_evaluated))

    do_eval_gates(new_potentials, new_evaluated)
  end

  @spec eval_gate({String.t, (circuit -> non_neg_integer)}, circuit) :: circuit
  defp eval_gate({gate, action}, evaluated) do
    try do
      value = action.(evaluated)
      Map.put(evaluated, gate, value)
    rescue
      ErlangError -> evaluated
    end
  end
end
