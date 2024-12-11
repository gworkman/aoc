defmodule AoC.Solutions.Y24.Day09 do
  use AoC.Solution

  @impl true
  def parse(raw_input, _opts) do
    raw_input
    |> String.trim()
    |> String.split("", trim: true)
    |> Enum.chunk_every(2, 2)
    |> Enum.reduce({[], 0}, fn block_space, {memory, block_id} ->
      case Enum.map(block_space, &String.to_integer/1) do
        [block_size, space] ->
          {[{:space, space}, {:block, block_size, block_id} | memory], block_id + 1}

        [block_size] ->
          [{:block, block_size, block_id} | memory]
      end
    end)
    |> Enum.reject(&(&1 == {:space, 0}))
    |> Enum.reverse()
  end

  @impl true
  def part_one(memory) do
    memory
    |> :queue.from_list()
    |> compact_memory(:blocks)
    |> :queue.to_list()
    |> expand_blocks()
    |> compute_checksum()
  end

  @impl true
  def part_two(memory) do
    memory
    |> :queue.from_list()
    |> compact_memory(:files)
    |> :queue.to_list()
    |> expand_blocks()
    |> compute_checksum()
  end

  def compact_memory(q, mode) do
    case :queue.out_r(q) do
      {:empty, _q} ->
        :queue.new()

      {{:value, {:block, _block_size, _id} = block}, q} ->
        {q, leftover} = move_blocks(q, block, mode)

        q
        |> compact_memory(mode)
        |> :queue.join(leftover)

      {{:value, space}, q} ->
        q = compact_memory(q, mode)
        :queue.in(space, q)
    end
  end

  def move_blocks(q, {:block, block_size, id} = block, mode) do
    case :queue.out(q) do
      {:empty, _q} ->
        {q, :queue.from_list([block])}

      {{:value, {:space, size}}, q} when size < block_size and mode == :blocks ->
        remaining_block = {:block, block_size - size, id}
        {q, leftover} = move_blocks(q, remaining_block, mode)

        {:queue.in_r({:block, size, id}, q), :queue.in({:space, size}, leftover)}

      {{:value, {:space, size}}, q} when size > block_size ->
        to_add = :queue.from_list([block, {:space, size - block_size}])
        q = :queue.join(to_add, q)
        {q, :queue.from_list([{:space, block_size}])}

      {{:value, {:space, size}}, q} when size == block_size ->
        {:queue.in_r(block, q), :queue.from_list([{:space, size}])}

      {{:value, unused_block}, q} ->
        {q, leftover} = move_blocks(q, block, mode)
        {:queue.in_r(unused_block, q), leftover}
    end
  end

  defp expand_blocks(blocks) do
    Enum.map(blocks, fn
      {:block, block_size, block_id} -> for _ <- 1..block_size, do: block_id
      {:space, size} -> for _ <- 1..size, do: nil
    end)
    |> List.flatten()
  end

  defp compute_checksum(blocks) do
    Enum.with_index(blocks)
    |> Enum.reject(fn {item, _index} -> is_nil(item) end)
    |> Enum.reduce(0, fn {item, index}, acc -> acc + item * index end)
  end
end
