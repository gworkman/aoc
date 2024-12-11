defmodule AoC.Solutions.Y24.Day11Test do
  use ExUnit.Case

  @part_one_example_solution 55_312

  def example_input() do
    """
    125 17
    """
  end

  test "part_one_example" do
    calculated =
      example_input()
      |> AoC.Solutions.Y24.Day11.parse()
      |> AoC.Solutions.Y24.Day11.part_one()

    assert @part_one_example_solution == calculated
  end

  test "part_two_example" do
    _calculated =
      example_input()
      |> AoC.Solutions.Y24.Day11.parse()
      |> AoC.Solutions.Y24.Day11.part_two()

    # here we are only testing for completion
    assert true == true
  end
end
