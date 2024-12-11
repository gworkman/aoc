defmodule AoC.Solutions.Y24.Day10Test do
  use ExUnit.Case

  @part_one_example_solution 36
  @part_two_example_solution 81

  def example_input() do
    """
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day10.parse()
      |> AoC.Solutions.Y24.Day10.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day10.parse()
      |> AoC.Solutions.Y24.Day10.part_two()

    assert @part_two_example_solution == calculated
  end
end
