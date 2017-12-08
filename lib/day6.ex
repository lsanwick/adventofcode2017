defmodule Day6 do
  @doc """
    Perform a redistribution of memory give a list of banks.

    ## Examples
      iex> Day6.redistribute([0, 2, 7, 0])
      {[2, 4, 1, 2], 5}

      iex> Day6.redistribute([14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4])
      {[2, 4, 1, 2], 5}
  """
  def redistribute(banks, history \\ %{}, count \\ 0) do
    largest = Enum.max(banks)
    IO.puts largest
    index = Enum.find_index(banks, fn(bank) -> bank == largest end)
    IO.puts index
    chunks = length(banks) - 1
    amount_per_chunk = div(largest, chunks)
    result =
      banks
      |> Stream.with_index
      |> Enum.map(fn({val, i}) -> if i == index, do: rem(largest, chunks), else: val + amount_per_chunk end)
    IO.inspect result
    if Map.has_key?(history, result) do
      { result, count + 1 }
    else
      history = Map.put(history, result, true)
      redistribute(result, history, count + 1)
    end
  end
end
