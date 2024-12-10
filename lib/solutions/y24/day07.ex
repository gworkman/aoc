defmodule AoC.Solutions.Y24.Day07 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [test_value, calibration_values] = String.split(line, ": ")

      test_value = String.to_integer(test_value)

      calibration_values =
        calibration_values
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      {test_value, calibration_values}
    end)
  end

  @impl true
  def part_one(data) do
    Enum.filter(data, fn {test_value, calibration_values} ->
      test_value in evaluate(calibration_values, [:add, :mult])
    end)
    |> Enum.reduce(0, fn {test_value, _calibration_values}, acc -> acc + test_value end)
  end

  @impl true
  def part_two(data) do
    Enum.filter(data, fn {test_value, calibration_values} ->
      test_value in evaluate(calibration_values, [:add, :mult, :concat])
    end)
    |> Enum.reduce(0, fn {test_value, _calibration_values}, acc -> acc + test_value end)
  end

  defp evaluate(items, operators) when is_list(operators) do
    operators
    |> Enum.map(&evaluate(items, &1, operators))
    |> List.flatten()
  end

  defp evaluate([a, b | rest], :add, operators) do
    case rest do
      [] -> a + b
      _rest -> Enum.map(operators, &evaluate([a + b | rest], &1, operators))
    end
  end

  defp evaluate([a, b | rest], :mult, operators) do
    case rest do
      [] -> a * b
      _rest -> Enum.map(operators, &evaluate([a * b | rest], &1, operators))
    end
  end

  defp evaluate([a, b | rest], :concat, operators) do
    case rest do
      [] -> concat(a, b)
      _rest -> Enum.map(operators, &evaluate([concat(a, b) | rest], &1, operators))
    end
  end

  def concat(a, b) do
    num_digits = num_digits(b)

    a * 10 ** num_digits + b
  end

  def num_digits(num, acc \\ 0)
  def num_digits(0, acc), do: acc
  def num_digits(num, acc), do: num_digits(div(num, 10), acc + 1)
end
