
defmodule Anagram do
    def anagram?(word1, word2), do: 0 == length (word1 -- word2) 
end


IO.inspect Anagram.anagram?('canoe','ocean')
IO.inspect Anagram.anagram?('can','cat')
IO.inspect Anagram.anagram?('dormitory','dirty room')
