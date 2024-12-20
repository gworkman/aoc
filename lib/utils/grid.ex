defmodule AoC.Utils.Grid do
  defstruct [:nrows, :ncols, :data]

  defmodule Location do
    defstruct [:row, :col, :value]
  end

  def new([first | _rest] = data) do
    nrows = length(data)
    ncols = length(first)

    %__MODULE__{nrows: nrows, ncols: ncols, data: data}
  end

  def iter(grid) do
    Enum.with_index(grid.data)
    |> Enum.map(fn {row, i} ->
      Enum.with_index(row)
      |> Enum.map(fn {item, j} -> %Location{row: i, col: j, value: item} end)
    end)
    |> List.flatten()
  end

  def shift(%__MODULE__{} = grid, %Location{} = loc, direction) when is_atom(direction) do
    case direction do
      :n -> clamp(grid, %{loc | row: loc.row - 1})
      :s -> clamp(grid, %{loc | row: loc.row + 1})
      :e -> clamp(grid, %{loc | col: loc.col + 1})
      :w -> clamp(grid, %{loc | col: loc.col - 1})
      :ne -> clamp(grid, %{loc | row: loc.row - 1, col: loc.col + 1})
      :nw -> clamp(grid, %{loc | row: loc.row - 1, col: loc.col - 1})
      :se -> clamp(grid, %{loc | row: loc.row + 1, col: loc.col + 1})
      :sw -> clamp(grid, %{loc | row: loc.row + 1, col: loc.col - 1})
    end
  end

  def shift(%__MODULE__{} = grid, %Location{} = loc, {nrows, ncols}) do
    clamp(grid, %{loc | row: loc.row + nrows, col: loc.col + ncols})
  end

  def put(%__MODULE__{} = grid, %Location{} = loc, value) do
    new_data =
      List.update_at(grid.data, loc.row, fn row ->
        List.replace_at(row, loc.col, value)
      end)

    %{grid | data: new_data}
  end

  def count_where(%__MODULE__{data: data}, value_or_fun) do
    fun =
      cond do
        is_function(value_or_fun) -> value_or_fun
        true -> fn val -> val == value_or_fun end
      end

    Enum.map(data, fn row ->
      Enum.filter(row, fun)
      |> Enum.count()
    end)
    |> Enum.sum()
  end

  defp clamp(%__MODULE__{} = grid, %Location{} = loc) do
    cond do
      loc.row >= grid.nrows -> nil
      loc.row < 0 -> nil
      loc.col >= grid.ncols -> nil
      loc.col < 0 -> nil
      true -> update_value(grid, loc)
    end
  end

  defp update_value(grid, loc) do
    updated_value =
      grid.data
      |> Enum.at(loc.row)
      |> Enum.at(loc.col)

    %{loc | value: updated_value}
  end
end
