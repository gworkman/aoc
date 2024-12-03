defmodule AoC.Solutions.Y24.Day03 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
  end

  @impl true
  def part_one(data) do
    data
    |> extract_instructions()
    |> Enum.reduce(0, fn [l, r], total -> total + l * r end)
  end

  @impl true
  def part_two(data) do
    data
    |> extract_instructions(true)
    |> Enum.reduce({:enabled, 0}, fn
      [l, r], {:enabled, total} -> {:enabled, total + l * r}
      [_l, _r], {:disabled, total} -> {:disabled, total}
      action, {_enabled, total} -> {action, total}
    end)
    |> elem(1)
  end

  defp extract_instructions(line, extract_conditions? \\ false) do
    case {line, extract_conditions?} do
      {"mul(" <> rest, _} ->
        with {left, rest} when is_number(left) <- extract_integer(rest),
             "," <> rest <- rest,
             {right, rest} when is_number(right) <- extract_integer(rest),
             ")" <> rest <- rest do
          [[left, right] | extract_instructions(rest, extract_conditions?)]
        else
          {nil, rest} -> extract_instructions(rest, extract_conditions?)
          rest -> extract_instructions(rest, extract_conditions?)
        end

      {"do()" <> rest, true} ->
        [:enabled | extract_instructions(rest, true)]

      {"don't()" <> rest, true} ->
        [:disabled | extract_instructions(rest, true)]

      {"", _} ->
        []

      {<<_any::binary-size(1), rest::binary>>, _} ->
        extract_instructions(rest, extract_conditions?)
    end
  end

  defp extract_integer(rest, acc \\ nil, num_digits \\ 3)

  defp extract_integer(<<val, rest::binary>>, nil, num_digits)
       when val in ?0..?9 and num_digits > 0 do
    extract_integer(rest, val - ?0, num_digits - 1)
  end

  defp extract_integer(<<val, rest::binary>>, acc, num_digits)
       when val in ?0..?9 and num_digits > 0 do
    extract_integer(rest, acc * 10 + (val - ?0), num_digits - 1)
  end

  defp extract_integer(rest, acc, _num_digits), do: {acc, rest}
end
