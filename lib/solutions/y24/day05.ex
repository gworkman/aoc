defmodule AoC.Solutions.Y24.Day05 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    [rules, print_order] = String.split(raw_input, "\n\n")

    rules =
      rules
      |> String.split()
      |> Enum.map(fn line ->
        line
        |> String.split("|")
        |> Enum.map(&String.to_integer/1)
      end)
      |> Enum.reduce(%{}, fn [num, before], rules ->
        Map.update(rules, num, [before], fn items -> [before | items] end)
      end)

    print_order =
      print_order
      |> String.split()
      |> Enum.map(fn line ->
        line
        |> String.split(",")
        |> Enum.map(&String.to_integer/1)
      end)

    {rules, print_order}
  end

  @impl true
  def part_one({rules, print_order}) do
    print_order
    |> Enum.filter(&valid_print_order?(&1, rules))
    |> Enum.map(fn valid_order ->
      mid_point = div(length(valid_order), 2)
      Enum.at(valid_order, mid_point)
    end)
    |> Enum.sum()
  end

  @impl true
  def part_two({rules, print_order}) do
    print_order
    |> Enum.reject(&valid_print_order?(&1, rules))
    |> Enum.map(&fix_order(&1, rules))
    |> Enum.map(fn order ->
      mid_point = div(length(order), 2)
      Enum.at(order, mid_point)
    end)
    |> Enum.sum()
  end

  defp valid_print_order?(print_order, rules) do
    item_order_map =
      print_order
      |> Enum.with_index()
      |> Map.new()

    for {item, pos} <- item_order_map do
      Map.get(rules, item, [])
      |> Enum.all?(fn rule ->
        case item_order_map[rule] do
          nil -> true
          rule_pos -> pos < rule_pos
        end
      end)
    end
    |> Enum.all?()
  end

  defp fix_order(print_order, rules) do
    item_order_map =
      print_order
      |> Enum.with_index()
      |> Map.new()

    Enum.reduce_while(item_order_map, print_order, fn {item, pos}, order ->
      rules_for_item = Map.get(rules, item, [])

      invalid_rule =
        Enum.find(rules_for_item, fn rule ->
          case item_order_map[rule] do
            nil -> false
            rule_pos -> rule_pos < pos
          end
        end)

      case invalid_rule do
        nil ->
          {:cont, order}

        _rule ->
          fixed_order =
            List.replace_at(order, pos, invalid_rule)
            |> List.replace_at(item_order_map[invalid_rule], item)

          {:halt, fix_order(fixed_order, rules)}
      end
    end)
  end
end
