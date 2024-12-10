defmodule AoC.Solutions.Y24.Day06 do
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
    starting_pos =
      grid
      |> Grid.iter()
      |> Enum.find(fn loc -> loc.value == "^" end)

    new_grid = trace_guard_path(grid, starting_pos, :n)

    new_grid.data
    |> Enum.reduce(0, fn row, acc ->
      visited_positions =
        Enum.filter(row, &(&1 == "X"))
        |> Enum.count()

      acc + visited_positions
    end)
  end

  @impl true
  def part_two(grid) do
    starting_pos =
      grid
      |> Grid.iter()
      |> Enum.find(fn loc -> loc.value == "^" end)

    Grid.iter(grid)
    |> Stream.reject(&(&1.value == "^" or &1.value == "#"))
    |> Task.async_stream(fn loc ->
      grid_with_obstacle = Grid.put(grid, loc, "#")

      has_cycle?(grid_with_obstacle, starting_pos, :n)
    end)
    |> Enum.filter(&elem(&1, 1))
    |> Enum.count()
  end

  defp trace_guard_path(grid, location, current_direction) do
    grid = Grid.put(grid, location, "X")

    case Grid.shift(grid, location, current_direction) do
      nil ->
        grid

      %{value: "#"} ->
        new_direction = rotate_right(current_direction)
        trace_guard_path(grid, location, new_direction)

      new_location ->
        trace_guard_path(grid, new_location, current_direction)
    end
  end

  defp has_cycle?(grid, location, current_direction, turns \\ %{}) do
    case Grid.shift(grid, location, current_direction) do
      nil ->
        false

      %{value: "#"} ->
        new_direction = rotate_right(current_direction)
        turn = {location, new_direction}

        cond do
          Map.has_key?(turns, turn) ->
            true

          true ->
            new_turns = Map.put(turns, turn, true)
            has_cycle?(grid, location, new_direction, new_turns)
        end

      new_location ->
        has_cycle?(grid, new_location, current_direction, turns)
    end
  end

  defp rotate_right(:n), do: :e
  defp rotate_right(:e), do: :s
  defp rotate_right(:s), do: :w
  defp rotate_right(:w), do: :n
end
