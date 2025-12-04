defmodule AoC.Solutions.Y25.Day04 do
  use AoC.Solution

  alias AoC.Utils.Grid

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Grid.new()
  end

  @impl true
  def part_one(data) do
    remove_paper(data)
    |> Grid.iter()
    |> Enum.filter(&(&1.value == "x"))
    |> length()
  end

  @impl true
  def part_two(data) do
    remove_all_paper(data)
    |> IO.inspect()
    |> Grid.iter()
    |> Enum.filter(&(&1.value == "x"))
    |> length()
  end

  defp remove_all_paper(grid) do
    new_grid = remove_paper(grid)

    cond do
      new_grid == grid -> new_grid
      true -> remove_all_paper(new_grid)
    end
  end

  defp remove_paper(grid) do
    directions = [:n, :ne, :e, :se, :s, :sw, :w, :nw]

    Grid.iter(grid)
    |> Enum.reduce(grid, fn %Grid.Location{} = loc, acc ->
      num_nearby_paper =
        for(dir <- directions, do: Grid.shift(grid, loc, dir))
        |> Enum.reject(&is_nil/1)
        |> Enum.count(&(&1.value == "@"))

      new_value =
        if(loc.value == "@" and num_nearby_paper < 4, do: "x", else: loc.value)

      Grid.put(acc, loc, new_value)
    end)
  end
end
