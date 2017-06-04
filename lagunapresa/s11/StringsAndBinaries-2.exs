defmodule MyString do
  def anagram?(word1, word2), do: (Enum.count(word1) == Enum.count(word2)) and (word1 -- word2 == [])
end
