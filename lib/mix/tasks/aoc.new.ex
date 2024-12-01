defmodule Mix.Tasks.Aoc.New do
  use Mix.Task

  @shortdoc "Generates new module for AoC challenge"
  @moduledoc """
  Generator for AoC challenge solutions.

  Usage: `mix aoc.new --year 2024 --day 1`

  Parameters:
  `--year YEAR`: the year for which you wish to generate the solution module. Defaults to the current year
  `--day DAY`: the day for which you wish to generate the solution module. Defaults to the current day
  `--force`: overwrite the file, if it already exists

  """

  @impl true
  def run(args) do
    shell = Mix.shell()

    {options, errors, invalid} =
      OptionParser.parse(args, strict: [year: :integer, day: :integer, force: :boolean])

    cond do
      length(errors) > 0 ->
        shell.error("Invalid usage. Run `mix help aoc.new` for help.")

      length(invalid) > 0 ->
        shell.error("Invalid usage. Run `mix help aoc.new` for help.")

      true ->
        {{current_year, _month, current_day}, _current_time} = :calendar.local_time()

        year =
          case Keyword.get(options, :year, current_year) do
            year when year > 2000 -> year - 2000
            year_short -> year_short
          end
          |> Integer.to_string()
          |> String.pad_leading(2, "0")

        day =
          options
          |> Keyword.get(:day, current_day)
          |> Integer.to_string()
          |> String.pad_leading(2, "0")

        force? = Keyword.get(options, :force, false)

        solution_filename = "lib/solutions/y#{year}/day#{day}.ex"
        solution_contents = template_solution(year, day)

        test_filename = "test/solutions/y#{year}/day#{day}_test.exs"
        test_contents = template_test(year, day)

        with :ok <- write_file(solution_filename, solution_contents, force?),
             :ok <- write_file(test_filename, test_contents, force?) do
          shell.info("Successfully created files: [#{solution_filename}, #{test_filename}]")
          :ok
        else
          {:error, {:file_exists, filename}} ->
            shell.info(
              "Error: file #{filename} already exists. Use the flag `--force` to overwrite."
            )
        end
    end
  end

  defp write_file(filename, contents, force) do
    case {File.exists?(filename), force} do
      {false, _force} ->
        filename
        |> Path.dirname()
        |> File.mkdir_p()

        File.write(filename, contents)

        :ok

      {_exists, true} ->
        filename
        |> Path.dirname()
        |> File.mkdir_p()

        File.write(filename, contents)

        :ok

      {true, false} ->
        {:error, {:file_exists, filename}}
    end
  end

  defp template_solution(year, day) do
    """
    defmodule AoC.Solutions.Y#{year}.Day#{day} do
      use AoC.Solution

      @impl true
      def parse(raw_input, _opts) do
        raw_input
      end

      @impl true
      def part_one(data) do
        0
      end

      @impl true
      def part_two(data) do
        0
      end
    end
    """
  end

  defp template_test(year, day) do
    """
    defmodule AoC.Solutions.Y#{year}.Day#{day}Test do
      use ExUnit.Case

      @part_one_example_solution 0
      @part_two_example_solution 0

      def example_input() do
        \"\"\"

        \"\"\"
      end

      test "part_one_example" do
        calculated =
          example_input()
          |> AoC.Solutions.Y#{year}.Day#{day}.parse()
          |> AoC.Solutions.Y#{year}.Day#{day}.part_one()

        assert @part_one_example_solution == calculated
      end

      test "part_two_example" do
        calculated =
          example_input()
          |> AoC.Solutions.Y#{year}.Day#{day}.parse()
          |> AoC.Solutions.Y#{year}.Day#{day}.part_two()

        assert @part_two_example_solution == calculated
      end
    end
    """
  end
end
