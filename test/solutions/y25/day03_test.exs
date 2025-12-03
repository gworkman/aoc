defmodule AoC.Solutions.Y25.Day03Test do
  use ExUnit.Case

  @part_one_example_solution 357
  @part_two_example_solution 3_121_910_778_619

  def example_input() do
    """
    987654321111111
    811111111111119
    234234234234278
    818181911112111
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day03.parse()
      |> AoC.Solutions.Y25.Day03.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day03.parse()
      |> AoC.Solutions.Y25.Day03.part_two()

    assert @part_two_example_solution == calculated
  end
end
