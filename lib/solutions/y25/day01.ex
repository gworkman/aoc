defmodule AoC.Solutions.Y25.Day01 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    String.split(raw_input)
    |> Enum.map(fn
      "L" <> number -> -String.to_integer(number)
      "R" <> number -> String.to_integer(number)
    end)
  end

  @impl true
  def part_one(data) do
    data
    |> Enum.scan(50, fn rotate, acc -> acc + rotate end)
    |> Enum.filter(fn value -> Integer.mod(value, 100) == 0 end)
    |> length
  end

  @impl true
  def part_two(data) do
    Enum.reduce(data, {50, 0}, fn rotate, {dial_pos, num_zero_crossings} ->
      new_pos = dial_pos + rotate

      {Integer.mod(new_pos, 100), num_zero_crossings + zeros_between(dial_pos, new_pos)}
    end)
    |> elem(1)
  end

  def zeros_between(0, new) when new < 0 do
    -(Integer.floor_div(new, 100) + 1)
  end

  def zeros_between(old, new) when new < 0 do
    old_rotations = Integer.floor_div(old, 100)
    new_rotations = Integer.floor_div(new, 100)
    num_rotations = abs(new_rotations - old_rotations)

    cond do
      Integer.mod(new, 100) == 0 -> num_rotations + 1
      true -> num_rotations
    end
  end

  def zeros_between(old, new) when new > 0 do
    old_rotations = Integer.floor_div(old, 100)
    new_rotations = Integer.floor_div(new, 100)
    abs(new_rotations - old_rotations)
  end

  def zeros_between(_old, 0), do: 1
end
