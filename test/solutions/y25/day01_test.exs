defmodule AoC.Solutions.Y25.Day01Test do
  use ExUnit.Case

  @part_one_example_solution 3
  @part_two_example_solution 6

  def example_input() do
    """
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day01.parse()
      |> AoC.Solutions.Y25.Day01.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day01.parse()
      |> AoC.Solutions.Y25.Day01.part_two()

    assert @part_two_example_solution == calculated
  end

  test "zeros between" do
    assert AoC.Solutions.Y25.Day01.zeros_between(50, -50) == 1
    assert AoC.Solutions.Y25.Day01.zeros_between(50, 0) == 1
    assert AoC.Solutions.Y25.Day01.zeros_between(50, 100) == 1
    assert AoC.Solutions.Y25.Day01.zeros_between(50, -150) == 2
    assert AoC.Solutions.Y25.Day01.zeros_between(50, -200) == 3
    assert AoC.Solutions.Y25.Day01.zeros_between(50, -201) == 3
    assert AoC.Solutions.Y25.Day01.zeros_between(1, 99) == 0
  end
end
