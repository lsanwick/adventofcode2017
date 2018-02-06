defmodule Day4 do
  @doc """
    Count the number of valid passphrases in a list of passphrases.

    ## Examples
      iex> Day4.validate_passphrases("aa bb cc\\naa bb aa dd\\nee ff gg")
      2

      iex> Day4.validate_passphrases("ab bb ba\\nab bc bd\\nioo oio ooi")
      1
  """
  def validate_passphrases(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&validate_no_duplicates(&1))
    |> Enum.filter(&validate_no_anagrams(&1))
    |> length
  end

  @doc """
    Check if a passphrase is valid (does not contain duplicate words)

    ## Examples
      iex> Day4.validate_no_duplicates("aa bb cc dd")
      true

      iex> Day4.validate_no_duplicates("aa bb aa dd")
      false
  """
  def validate_no_duplicates(passphrase) do
    words =
      passphrase
      |> String.split(" ")

    length(words) == length(Enum.uniq(words))
  end

  @doc """
    Check if a passphrase is valid (no anagrams)

    ## Examples
      iex> Day4.validate_no_anagrams("abcde fghij")
      true

      iex> Day4.validate_no_anagrams("abcde xyz ecdab")
      false

      iex> Day4.validate_no_anagrams("a ab abc abd abf abj")
      true

      iex> Day4.validate_no_anagrams("oiii ioii iioi iiio")
      false
  """
  def validate_no_anagrams(passphrase) do
    words =
      passphrase
      |> String.split(" ")
      |> Enum.map(&standardize_word(&1))

    length(words) == length(Enum.uniq(words))
  end

  def standardize_word(word) do
    word
    |> String.graphemes()
    |> Enum.sort()
  end
end
