defmodule Day6 do
  @doc """
    Perform a redistribution of memory give a list of banks.

    ## Examples
      iex> Day6.redistribute([0, 2, 7, 0])
      {[2, 4, 1, 2], 5}

      iex> Day6.redistribute([14, 0, 15, 12, 11, 11, 3, 5, 1, 6, 8, 4, 9, 1, 8, 4])
      {[14, 13, 12, 11, 9, 8, 8, 6, 6, 4, 4, 3, 1, 1, 0, 12], 11137}

      iex> Day6.redistribute([14, 13, 12, 11, 9, 8, 8, 6, 6, 4, 4, 3, 1, 1, 0, 12])
      {[14, 13, 12, 11, 9, 8, 8, 6, 6, 4, 4, 3, 1, 1, 0, 12], 1037}
  """
  def redistribute(banks, history \\ %{}, count \\ 0) do
    history =
      if count == 0 do
        Map.put(history, banks, true)
      else
        history
      end

    largest = Enum.max(banks)
    index = Enum.find_index(banks, fn bank -> bank == largest end)

    result =
      1..largest
      |> Enum.map(fn offset -> rem(index + offset, length(banks)) end)
      |> Enum.reduce(List.wrap(banks), fn index, acc ->
        List.replace_at(acc, index, Enum.at(acc, index) + 1)
      end)

    result = List.replace_at(result, index, Enum.at(result, index) - largest)

    if Map.has_key?(history, result) do
      {result, count + 1}
    else
      history = Map.put(history, result, true)
      redistribute(result, history, count + 1)
    end
  end
end
