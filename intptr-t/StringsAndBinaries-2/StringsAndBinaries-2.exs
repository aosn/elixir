defmodule Chars do
    def anagram?(word1, word2), do: Enum.sort(word1) == Enum.sort(word2)
end

# iex(1)> Chars.anagram?('abc', 'acb')
# true
# iex(2)> Chars.anagram?('abc', 'bca')
# true
# iex(3)> Chars.anagram?('abc', 'bcaa')
# false
# iex(4)> Chars.anagram?('abc', 'aaa')
# false
# iex(5)> Chars.anagram?('abc', 'Abc')
# false
# iex(6)> Chars.anagram?('abc', 'ab')
# false
