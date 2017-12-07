use Bitwise

defmodule Day3B do
  @moduledoc """
  Find shortest distance in spiral matrix path
  """

  @doc """
    Get the Manhattan distance for a given number

    ## Examples
    iex> Day3B.get_distance(1)
    0
    iex> Day3B.get_distance(12)
    3
    iex> Day3B.get_distance(23)
    2
    iex> Day3B.get_distance(1024)
    31
  """
  def get_distance(num) do
    {_, _, _, val} = build_matrix(num)
    val
  end

  @doc """
  Given a number, build a spiral matrix starting with 1 at the center

  ## Examples

      iex> Day3B.build_matrix(1)
      {%{{0, 0} => 1}, :down, {0, 0}}
      iex> Day3B.build_matrix(2)
      {%{{0, 0} => 1, {1, 0} => 2}, :right, {1, 0}}
  """
  def build_matrix(max_value, {positions, direction, position}) do
    if left_filled(positions, direction, position) do
      position = move(direction, position)
    else
      direction = turn_left(direction)
      position = move(direction, position)
    end
    value = cell_value(positions, position)
    positions = Map.put(positions, position, value)
    build_matrix(max_value, {positions, direction, position})
  end
  def build_matrix(1), do: {%{{0,0} => 1}, :down, {0,0}, 1}
  @doc """
    Check if the position to the left is filled

    ## Examples
      iex> Day3B.left_filled(%{{0,0} => 1}, :up, {1, 0})
      true
      iex> Day3B.left_filled(%{{0,0} => 1, {1,0} => 2}, :up, {1, 1})
      false
  """
  def left_filled(positions, direction, current_position) do
    check_position =
      turn_left(direction)
      |> move(current_position)

    case Map.fetch(positions, check_position) do
      {:ok, _ } -> true
      :error -> false
    end
  end

  @doc """
    Get the cell value for part 2 of the problem (part 1 has no calculation)

    ## Examples
      iex> Day3B.cell_value(%{{0, 0} => 1, {1, 0} => 1, {1, 1} => 2}, {0, 1})
      4
  """
  def cell_value(_, {0,0}), do: 1
  def cell_value(positions, position) do
    {x, y} = position
    neighbors = [
      {x-1, y+1},
      {x, y+1},
      {x+1, y+1},
      {x+1, y},
      {x+1, y-1},
      {x, y-1},
      {x-1, y-1},
      {x-1, y},
    ]
    values = for neighbor <- neighbors, do: Map.get(positions, neighbor, 0)
    Enum.sum(values)
  end

  def move(:up, {x, y}), do: {x, y+1}
  def move(:right, {x, y}), do: {x+1, y}
  def move(:down, {x, y}), do: {x, y-1}
  def move(:left, {x, y}), do: {x-1, y}

  @doc """
    Determine which direction to go after turning left

    ## Examples
      iex> Day3B.turn_left(:up)
      :left
  """
  def turn_left(:up), do: :left
  def turn_left(:right), do: :up
  def turn_left(:down), do: :right
  def turn_left(:left), do: :down
end
