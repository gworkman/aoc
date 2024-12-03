defmodule AoC.Solutions.Y24.Day03Test do
  use ExUnit.Case

  @part_one_example_solution 161
  @part_two_example_solution 48

  def example_input() do
    """
    xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day03.parse()
      |> AoC.Solutions.Y24.Day03.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day03.parse()
      |> AoC.Solutions.Y24.Day03.part_two()

    assert @part_two_example_solution == calculated
  end
end
