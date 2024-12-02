defmodule AoC.Solutions.Y24.Day02 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @impl true
  def part_one(data) do
    Enum.reduce(data, 0, fn line, total ->
      cond do
        is_safe_report?(line) -> total + 1
        true -> total
      end
    end)
  end

  defp is_safe_report?(line, opts \\ [])

  defp is_safe_report?(line, allow_skip?: true) do
    report_len = length(line)

    Enum.reduce_while(0..(report_len - 1), nil, fn remove_index, _acc ->
      is_safe? =
        line
        |> List.delete_at(remove_index)
        |> is_safe_report?()

      halt_cont = if is_safe?, do: :halt, else: :cont

      {halt_cont, is_safe?}
    end)
  end

  defp is_safe_report?(line, _opts) do
    Enum.reduce_while(line, {nil, nil}, fn
      item, {nil, nil} ->
        {:cont, {nil, item}}

      item, {second_last_item, last_item} ->
        cond do
          abs(item - last_item) > 3 -> {:halt, false}
          is_nil(second_last_item) -> {:cont, {last_item, item}}
          second_last_item < last_item and last_item < item -> {:cont, {last_item, item}}
          second_last_item > last_item and last_item > item -> {:cont, {last_item, item}}
          true -> {:halt, false}
        end
    end)
    |> case do
      acc when is_tuple(acc) -> true
      false -> false
    end
  end

  @impl true
  def part_two(data) do
    Enum.reduce(data, 0, fn line, total ->
      cond do
        is_safe_report?(line, allow_skip?: true) -> total + 1
        true -> total
      end
    end)
  end
end
