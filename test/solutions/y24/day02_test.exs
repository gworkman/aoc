defmodule AoC.Solutions.Y24.Day02Test do
  use ExUnit.Case

  @part_one_example_solution 0
  @part_two_example_solution 0

  def example_input() do
    """

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
