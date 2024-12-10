defmodule AoC.Solutions.Y24.Day07Test do
  use ExUnit.Case

  @part_one_example_solution 3749
  @part_two_example_solution 11387

  def example_input() do
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day07.parse()
      |> AoC.Solutions.Y24.Day07.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day07.parse()
      |> AoC.Solutions.Y24.Day07.part_two()

    assert @part_two_example_solution == calculated
  end
end
