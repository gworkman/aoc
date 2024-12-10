defmodule AoC.Solutions.Y24.Day08 do
  use AoC.Solution

  alias AoC.Utils.Grid

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.split()
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Grid.new()
  end

  @impl true
  def part_one(grid) do
    Grid.iter(grid)
    |> Enum.reject(fn loc -> loc.value == "." end)
    |> Enum.reduce(%{}, fn loc, nodes ->
      Map.update(nodes, loc.value, [loc], fn locs -> [loc | locs] end)
    end)
    |> Enum.reduce(grid, fn {_signal, antennas}, grid ->
      antenna_pairs = antenna_pairs(antennas)

      Enum.reduce(antenna_pairs, grid, fn {first, second}, grid ->
        antenna_directions(first, second)
        |> Enum.zip([first, second])
        |> Enum.reduce(grid, fn {dir, loc}, grid -> put_antinode(grid, loc, dir) end)
      end)
    end)
    |> Grid.count_where("#")
  end

  @impl true
  def part_two(grid) do
    antenna_locs =
      Grid.iter(grid)
      |> Enum.reject(fn loc -> loc.value == "." end)

    antenna_locs
    |> Enum.reduce(%{}, fn loc, nodes ->
      Map.update(nodes, loc.value, [loc], fn locs -> [loc | locs] end)
    end)
    |> Enum.reduce(grid, fn {_signal, antennas}, grid ->
      antenna_pairs = antenna_pairs(antennas)

      Enum.reduce(antenna_pairs, grid, fn {first, second}, grid ->
        antenna_directions(first, second)
        |> Enum.zip([first, second])
        |> Enum.reduce(grid, fn {dir, loc}, grid -> put_all_antinodes(grid, loc, dir) end)
      end)
    end)
    |> Grid.count_where(&(&1 != "."))
  end

  defp antenna_pairs(antennas) do
    for i <- 0..(length(antennas) - 1),
        j <- i..(length(antennas) - 1),
        i != j do
      {Enum.at(antennas, i), Enum.at(antennas, j)}
    end
  end

  defp antenna_directions(first, second) do
    d_rows = first.row - second.row
    d_cols = first.col - second.col

    [{d_rows, d_cols}, {-d_rows, -d_cols}]
  end

  defp put_antinode(grid, loc, direction) do
    case Grid.shift(grid, loc, direction) do
      nil -> grid
      new_loc -> Grid.put(grid, new_loc, "#")
    end
  end

  defp put_all_antinodes(grid, loc, direction) do
    case Grid.shift(grid, loc, direction) do
      nil ->
        grid

      new_loc ->
        Grid.put(grid, new_loc, "#")
        |> put_all_antinodes(new_loc, direction)
    end
  end
end
