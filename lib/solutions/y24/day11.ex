defmodule AoC.Solutions.Y24.Day11 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end

  @impl true
  def part_one(stones) do
    {total_stones, _memo} =
      Enum.reduce(stones, {0, %{}}, fn stone, {total_stones, memo} ->
        {stones, memo} = blink(stone, 25, memo)
        {total_stones + stones, memo}
      end)

    total_stones
  end

  @impl true
  def part_two(stones) do
    {total_stones, _memo} =
      Enum.reduce(stones, {0, %{}}, fn stone, {total_stones, memo} ->
        {stones, memo} = blink(stone, 75, memo)
        {total_stones + stones, memo}
      end)

    total_stones
  end

  def blink(_stone, 0, memo), do: {1, memo}

  def blink(stone, times, memo) do
    digits = num_digits(stone)

    cond do
      Map.has_key?(memo, {stone, times}) ->
        total_stones = Map.get(memo, {stone, times})
        {total_stones, memo}

      stone == 0 ->
        {total_stones, memo} = blink(1, times - 1, memo)
        memo = Map.put(memo, {stone, times}, total_stones)

        {total_stones, memo}

      rem(digits, 2) == 0 ->
        [l, r] = split(stone, div(digits, 2))
        {l_total, memo} = blink(l, times - 1, memo)
        {r_total, memo} = blink(r, times - 1, memo)

        total_stones = l_total + r_total
        memo = Map.put(memo, {stone, times}, total_stones)

        {total_stones, memo}

      true ->
        {total_stones, memo} = blink(stone * 2024, times - 1, memo)
        memo = Map.put(memo, {stone, times}, total_stones)

        {total_stones, memo}
    end
  end

  def num_digits(0), do: 0

  def num_digits(stone) do
    div(stone, 10)
    |> num_digits()
    |> then(&(&1 + 1))
  end

  def split(stone, digits) do
    Enum.reduce(0..(digits - 1), [stone, 0], fn i, [l, r] ->
      [div(l, 10), r + rem(l, 10) * 10 ** i]
    end)
  end
end
