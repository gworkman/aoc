defmodule AoC.Solutions.Y25.Day02Test do
  use ExUnit.Case

  @part_one_example_solution 1_227_775_554
  @part_two_example_solution 4_174_379_265

  def example_input() do
    """
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day02.parse()
      |> AoC.Solutions.Y25.Day02.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y25.Day02.parse()
      |> AoC.Solutions.Y25.Day02.part_two()

    assert @part_two_example_solution == calculated
  end
end
