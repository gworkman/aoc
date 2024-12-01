defmodule AoC.Solution do
  @doc "Parses the raw input into a data structure"
  @callback parse(raw_input :: String.t(), opts :: Keyword.t()) :: any()

  @doc "Computes the solution for part one"
  @callback part_one(data :: any()) :: integer()

  @doc "Computes the solution for part one"
  @callback part_two(data :: any()) :: integer()

  defmacro __using__(_opts) do
    quote do
      @behaviour AoC.Solution

      [year_mod, day_mod] =
        Module.split(__MODULE__)
        |> Enum.drop_while(fn mod_name ->
          not String.starts_with?(mod_name, "Y")
        end)

      "Y" <> year_str = year_mod
      "Day" <> day_str = day_mod

      @year 2000 + String.to_integer(year_str)
      @day String.to_integer(day_str)

      def year, do: @year
      def day, do: @day

      def run do
        with {:ok, input} <- AoC.Problem.input(year(), day()),
             data <- __MODULE__.parse(input, []) do
          part_one = __MODULE__.part_one(data)
          part_two = __MODULE__.part_two(data)

          {:ok, {part_one, part_two}}
        end
      end

      def parse(raw_input, opts \\ [])
    end
  end
end
