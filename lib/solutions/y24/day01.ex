defmodule AoC.Solutions.Y24.Day01 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn row ->
      row
      |> String.split()
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
    end)
    |> Enum.unzip()
  end

  @impl true
  def part_one({first_list, second_list}) do
    for list <- [first_list, second_list] do
      Enum.sort(list)
    end
    |> Enum.zip()
    |> Enum.reduce(0, fn {left, right}, total ->
      total + abs(left - right)
    end)
  end

  @impl true
  def part_two({first_list, second_list}) do
    frequencies = Enum.frequencies(second_list)

    Enum.reduce(first_list, 0, fn item, total ->
      total + item * Map.get(frequencies, item, 0)
    end)
  end
end
