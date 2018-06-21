defmodule PhoneToString do
  @mapping %{
    "1" => ["1"],
    "2" => ["A", "B", "C"],
    "3" => ["D", "E", "F"],
    "4" => ["G", "H", "I"],
    "5" => ["J", "K", "L"],
    "6" => ["M", "N", "O"],
    "7" => ["P", "Q", "R", "S"],
    "8" => ["T", "U", "V"],
    "9" => ["W", "X", "Y", "Z"],
    "0" => ["0"]
  }

  @doc """
    Append the mapping for the given character to the end of each string in a list, returning the
    mapping itself if there are no strings to append onto.

    ## Examples
      iex> PhoneToString.append_to_existing("6", ["A", "B", "C"])
      ["AM", "BM", "CM", "AN", "BN", "CN", "AO", "BO", "CO"]

      iex> PhoneToString.append_to_existing("2", [])
      ["A", "B", "C"]
  """
  def append_to_existing(char, []), do: @mapping[char]

  def append_to_existing(char, strings) do
    Enum.flat_map(@mapping[char], fn letter ->
      Enum.map(strings, fn string -> string <> letter end)
    end)
  end

  @doc """
    Given a list of digits, return a list of strings for all character permutations given @mapping.
  """
  def get_permutations(_, acc \\ [])
  def get_permutations([], acc), do: acc

  def get_permutations([x | tail], acc) do
    get_permutations(tail, append_to_existing(x, acc))
  end

  def get_permutations_slow([]), do: []
  def get_permutations_slow([x]), do: @mapping[x]

  def get_permutations_slow([x | tail]) when length(tail) > 0 do
    Enum.flat_map(@mapping[x], fn char ->
      Enum.map(get_permutations_slow(tail), fn string -> char <> string end)
    end)
  end

  @doc """
    Get all permutations of an input of digits and return them as a list.

    ## Examples
      iex> PhoneToString.call("1")
      ["1"]

      iex> PhoneToString.call("2")
      ["A", "B", "C"]

      iex> PhoneToString.call("23") |> Enum.sort()
      ["AD", "AE", "AF", "BD", "BE", "BF", "CD", "CE", "CF"]

      iex> PhoneToString.call("")
      []
  """
  def call(input) do
    input
    |> String.codepoints()
    |> get_permutations
  end

  def call_slow(input) do
    input
    |> String.codepoints()
    |> get_permutations_slow
  end
end
