defmodule Day1 do
  @moduledoc """
  Sum matching numbers
  """

  @doc """
  Return the sum of a matching numbers in an input string.

  ## Examples

      iex> Day1.find_match_sum("1122")
      3
      iex> Day1.find_match_sum("1111")
      4
      iex> Day1.find_match_sum("1234")
      0
      iex> Day1.find_match_sum("91212129")
      9

  """
  def find_match_sum(string) do
    int_array = string
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)

    acc =
      if List.first(int_array) == List.last(int_array) do
        [List.first(int_array)]
      else
        []
      end
    Enum.sum get_matching_chars(int_array, acc)
  end

  @doc """
  Return an array of characters that match the next character in the array (looping at the end)

  ## Examples

    iex> Day1.get_matching_chars([1, 1, 2, 2])
    [2, 1]

    iex> Day1.get_matching_chars([1, 2, 3, 4])
    []
  """
  def get_matching_chars(input_chars, acc \\ []) when length(input_chars) > 1 do
    [ first | rest ] = input_chars
    [ next | _ ] = rest
    case { first, next, rest } do
      { ^first, ^first, rest} ->
        get_matching_chars(rest, [first | acc] )
      _ ->
        get_matching_chars(rest, acc)
    end
  end

  def get_matching_chars([], acc),  do: acc
  def get_matching_chars([_], acc),  do: acc
end
