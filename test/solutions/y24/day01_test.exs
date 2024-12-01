defmodule AoC.Solutions.Y24.Day01Test do
  use ExUnit.Case

  def example_input() do
    """
    3   4
    4   3
    2   5
    1   3
    3   9
    3   3
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day01.parse()
      |> AoC.Solutions.Y24.Day01.part_one()

    assert 11 == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day01.parse()
      |> AoC.Solutions.Y24.Day01.part_two()

    assert 31 == calculated
  end
end
