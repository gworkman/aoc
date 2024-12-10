defmodule AoC.Solutions.Y24.Day08Test do
  use ExUnit.Case

  @part_one_example_solution 14
  @part_two_example_solution 34

  def example_input() do
    """
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day08.parse()
      |> AoC.Solutions.Y24.Day08.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day08.parse()
      |> AoC.Solutions.Y24.Day08.part_two()

    assert @part_two_example_solution == calculated
  end
end
