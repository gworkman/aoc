defmodule AoC.Solutions.Y25.Day03 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split()
    |> Enum.map(fn line ->
      for <<batt_str::binary-size(1) <- line>>, do: String.to_integer(batt_str)
    end)
  end

  @impl true
  def part_one(data) do
    data
    |> Enum.map(&calculate_max_joltage(&1, 2))
    |> Enum.sum()
  end

  @impl true
  def part_two(data) do
    data
    |> Enum.map(&calculate_max_joltage(&1, 12))
    |> Enum.sum()
  end

  def calculate_max_joltage(bank, 1), do: Enum.max(bank)

  def calculate_max_joltage(bank, num_batteries) do
    bank_size = length(bank)

    {max_battery, max_battery_index} =
      bank
      |> Enum.take(bank_size - (num_batteries - 1))
      |> Enum.with_index()
      |> Enum.max_by(&elem(&1, 0))

    rest_of_bank = Enum.drop(bank, max_battery_index + 1)

    current_battery_exponent = :math.pow(10, num_batteries - 1)
    joltage_rest = calculate_max_joltage(rest_of_bank, num_batteries - 1)

    (max_battery * current_battery_exponent + joltage_rest)
    |> round
  end
end
