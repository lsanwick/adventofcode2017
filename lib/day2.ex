defmodule Day2 do
  @moduledoc """
  Find max difference between numbers in a row, then calculate a checksum by summing all differences
  """

  @doc """
  Calculate a checksum from max difference of all rows in the input

  ## Examples

      iex> Day2.calculate_checksum("5 1 9 5\\n7 5 3\\n2 4 6 8")
      18

      iex> Day2.calculate_checksum("5 9 2 8\\n9 4 7 3\\n3 8 6 5", true)
      9
  """
  def calculate_checksum(input, division \\ false) do
    rows = String.split(input, "\n")

    result =
      if division do
        Enum.map(rows, &calculate_even_division/1)
      else
        Enum.map(rows, &calculate_max_difference/1)
      end

    result
    |> Enum.sum()
  end

  @doc """
  Return the sum of a matching numbers in an input string.

  ## Examples

      iex> Day2.calculate_max_difference("5 1 9 5")
      8

      iex> Day2.calculate_max_difference("7 5 3")
      4

      iex> Day2.calculate_max_difference("2 4 6 8")
      6
  """
  def calculate_max_difference(row_string) do
    numbers = row_numbers(row_string)
    Enum.max(numbers, fn -> 0 end) - Enum.min(numbers, fn -> 0 end)
  end

  @doc """
  Return quotient of the even divisors in a row.

  ## Examples

      iex> Day2.calculate_even_division("5 9 2 8")
      4

      iex> Day2.calculate_even_division("9 4 7 3")
      3

      iex> Day2.calculate_even_division("3 8 6 5")
      2
  """
  def calculate_even_division(row_string) do
    numbers = row_numbers(row_string)
    do_row_remainder(numbers)
  end

  def do_row_remainder([num | rest]) when length(rest) > 0 do
    matches = Enum.filter(rest, fn el -> rem(num, el) == 0 || rem(el, num) == 0 end)

    case List.first(matches) do
      nil -> do_row_remainder(rest)
      x -> if x > num, do: div(x, num), else: div(num, x)
    end
  end

  def do_row_remainder([]) do
    0
  end

  def row_numbers(row_string) do
    String.split(row_string, " ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
