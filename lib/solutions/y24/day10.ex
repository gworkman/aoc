defmodule AoC.Solutions.Y24.Day10 do
  use AoC.Solution

  alias AoC.Utils.Grid

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Grid.new()
  end

  @impl true
  def part_one(grid) do
    trailheads =
      Grid.iter(grid)
      |> Enum.filter(fn loc -> loc.value == 0 end)

    Enum.map(trailheads, fn trailhead ->
      find_trail_endpoints(grid, trailhead)
      |> Enum.uniq()
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  @impl true
  def part_two(grid) do
    trailheads =
      Grid.iter(grid)
      |> Enum.filter(fn loc -> loc.value == 0 end)

    Enum.map(trailheads, fn trailhead ->
      find_trail_endpoints(grid, trailhead)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp find_trail_endpoints(_grid, %{value: 9} = loc), do: loc

  defp find_trail_endpoints(grid, loc) do
    [:n, :e, :s, :w]
    |> Enum.map(&Grid.shift(grid, loc, &1))
    |> Enum.reject(&is_nil/1)
    |> Enum.filter(fn next_loc ->
      next_loc.value == loc.value + 1
    end)
    |> Enum.map(&find_trail_endpoints(grid, &1))
    |> List.flatten()
  end
end
