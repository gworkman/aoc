defmodule AoC.Solutions.Y24.Day09Test do
  use ExUnit.Case

  @part_one_example_solution 1928
  @part_two_example_solution 2858

  def example_input() do
    """
    2333133121414131402
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day09.parse()
      |> AoC.Solutions.Y24.Day09.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day09.parse()
      |> AoC.Solutions.Y24.Day09.part_two()

    assert @part_two_example_solution == calculated
  end
end
