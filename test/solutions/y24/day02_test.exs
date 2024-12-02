defmodule AoC.Solutions.Y24.Day02Test do
  use ExUnit.Case

  @part_one_example_solution 2
  @part_two_example_solution 4

  def example_input() do
    """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day02.parse()
      |> AoC.Solutions.Y24.Day02.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day02.parse()
      |> AoC.Solutions.Y24.Day02.part_two()

    assert @part_two_example_solution == calculated
  end
end
