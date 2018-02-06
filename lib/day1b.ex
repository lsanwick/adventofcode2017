defmodule Day1B do
  @moduledoc """
  Sum matching numbers with arbitrary distances
  """

  @doc """
  Return the sum of matching numbers in an input string.

  ## Examples

      iex> Day1B.find_match_sum("1122")
      3

      iex> Day1B.find_match_sum("1111")
      4

      iex> Day1B.find_match_sum("1234")
      0

      iex> Day1B.find_match_sum("91212129")
      9

      iex> Day1B.find_match_sum("1212", true)
      6

      iex> Day1B.find_match_sum("1221", true)
      0

      iex> Day1B.find_match_sum("123425", true)
      4
  """
  def find_match_sum(string, halfway \\ false) do
    int_array =
      string
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    distance =
      if halfway do
        div(length(int_array), 2)
      else
        1
      end

    Enum.sum(get_matching_chars(int_array, distance))
  end

  @doc """
  Return an array of characters that match the character which is `distance` away in the array
  (looping at the end)

  ## Examples

    iex> Day1B.get_matching_chars([1, 1, 2, 2])
    [1, 2]

    iex> Day1B.get_matching_chars([1,2,1,2], 2)
    [1, 2, 1, 2]
  """
  def get_matching_chars(input_chars, distance \\ 1) do
    input_chars
    |> Stream.with_index()
    |> Enum.filter(fn {_, index} -> matches_comparison_digit(input_chars, index, distance) end)
    |> Enum.unzip()
    |> (fn {results, _} -> results end).()
  end

  def matches_comparison_digit(chars, index, distance) do
    comp_index = rem(index + distance, length(chars))
    Enum.at(chars, index) == Enum.at(chars, comp_index)
  end
end
