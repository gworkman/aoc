defmodule AoC.Solutions.Y24.Day05Test do
  use ExUnit.Case

  @part_one_example_solution 143
  @part_two_example_solution 123

  def example_input() do
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day05.parse()
      |> AoC.Solutions.Y24.Day05.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day05.parse()
      |> AoC.Solutions.Y24.Day05.part_two()

    assert @part_two_example_solution == calculated
  end
end
