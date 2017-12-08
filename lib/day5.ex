defmodule Day5 do
  @doc """
    Jumps until escaping the list, returning the count of jumps needed

    ## Examples
      iex(1)> Day5.jump(Day5.convert_to_map([0, 3, 0, 1, -3]))
      {10, [2, 3, 2, 3, -1]}
  """
  def jump(list, size \\ 1, index \\ 0, count \\ 0)
  def jump(list, size, index, count) when index >= size, do: {count, Map.values(list)}
  def jump(list, _size, index, count) when index < 0, do: {count, Map.values(list)}
  def jump(list, _size, index, count) do
    offset = Map.get(list, index, 0)
    new_offset = if offset >= 3, do: offset - 1, else: offset + 1
    new_list = Map.put(list, index, new_offset)
    jump(new_list, Map.size(new_list), index + offset, count + 1)
  end

  def parse_string(string) do
    string
    |> String.trim
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> convert_to_map
  end

  def convert_to_map(list) do
    list
    |> Stream.with_index
    |> Stream.map(fn {instruction, index} -> {index, instruction} end)
    |> Map.new()
  end
end

# input_list = input |> String.split("\n", trim: true) |> Enum.map(&(String.to_integer(&1)))
