defmodule AoC.Solutions.Y24.Day04Test do
  use ExUnit.Case

  @part_one_example_solution 18
  @part_two_example_solution 9

  def example_input() do
    """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day04.parse()
      |> AoC.Solutions.Y24.Day04.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day04.parse()
      |> AoC.Solutions.Y24.Day04.part_two()

    assert @part_two_example_solution == calculated
  end
end
