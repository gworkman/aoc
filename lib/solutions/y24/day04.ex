defmodule AoC.Solutions.Y24.Day04 do
  use AoC.Solution

  alias AoC.Utils.Grid

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  @impl true
  def part_one(data) do
    grid = Grid.new(data)

    grid
    |> Grid.iter()
    |> Enum.reduce(0, fn
      %{value: "X"} = loc, xmas_count ->
        [:n, :ne, :e, :se, :s, :sw, :w, :nw]
        |> Enum.filter(fn dir -> xmas?(grid, loc, dir) end)
        |> then(fn valid_xmases -> xmas_count + length(valid_xmases) end)

      _loc, xmas_count ->
        xmas_count
    end)
  end

  @impl true
  def part_two(data) do
    grid = Grid.new(data)

    grid
    |> Grid.iter()
    |> Enum.reduce(0, fn
      %{value: "A"} = loc, x_mas_count ->
        cond do
          x_mas?(grid, loc) -> x_mas_count + 1
          true -> x_mas_count
        end

      _loc, x_mas_count ->
        x_mas_count
    end)
  end

  defp xmas?(grid, loc, dir) do
    next_loc = Grid.shift(grid, loc, dir)

    case {loc, next_loc} do
      {%{value: "X"}, %{value: "M"}} -> xmas?(grid, next_loc, dir)
      {%{value: "M"}, %{value: "A"}} -> xmas?(grid, next_loc, dir)
      {%{value: "A"}, %{value: "S"}} -> true
      _otherwise -> false
    end
  end

  defp x_mas?(grid, loc) do
    [[:ne, :sw], [:nw, :se]]
    |> Enum.all?(fn [d1, d2] ->
      with %{value: v1} <- Grid.shift(grid, loc, d1),
           %{value: v2} <- Grid.shift(grid, loc, d2) do
        Enum.sort([v1, v2]) == ["M", "S"]
      else
        _ -> false
      end
    end)
  end
end
