defmodule AoC.Solutions.Y25.Day02 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn id_range ->
      [id_start, id_end] =
        String.split(id_range, "-")
        |> Enum.map(&String.to_integer/1)

      {id_start, id_end}
    end)
  end

  @impl true
  def part_one(data) do
    data
    |> Enum.flat_map(fn {id_start, id_end} ->
      for id <- id_start..id_end, invalid_id?(id), do: id
    end)
    |> Enum.sum()
  end

  @impl true
  def part_two(data) do
    data
    |> Enum.flat_map(fn {id_start, id_end} ->
      for id <- id_start..id_end, invalid_id?(id, 2..num_digits(id)//1), do: id
    end)
    |> Enum.sum()
  end

  def invalid_id?(id, parts \\ 2)

  def invalid_id?(id, parts) when is_integer(id), do: Integer.to_string(id) |> invalid_id?(parts)

  # ranges are structs which are enumerable, so check is_map here
  def invalid_id?(id, parts) when is_map(parts) or is_list(parts) do
    for part_size <- parts do
      invalid_id?(id, part_size)
    end
    |> Enum.any?()
  end

  def invalid_id?(id_str, parts) do
    num_digits = String.length(id_str)
    chunk_size = div(num_digits, parts)

    cond do
      # when it won't go cleanly into the digits, it can't be an invalid id
      chunk_size != num_digits / parts ->
        false

      true ->
        chunks = for <<chunk::binary-size(chunk_size) <- id_str>>, do: chunk
        [first_chunk | _rest] = chunks

        Enum.map(chunks, &(&1 == first_chunk))
        |> Enum.all?()
    end
  end

  defp num_digits(id) when is_integer(id), do: Integer.to_string(id) |> num_digits()
  defp num_digits(id_str) when is_binary(id_str), do: String.length(id_str)
end
