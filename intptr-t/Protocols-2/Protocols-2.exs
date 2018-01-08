## from ListsAndRecursion-3
defmodule MyList do
  def caesar(list, n) do
    _caesar(list, n)
  end

  defp _caesar([], _n), do: []
  defp _caesar([head | tail], n) do
    # 'a' := 97
    # total lower-case letter is 26
    [rem(head + n - 97, 26) + 97 | _caesar(tail, n)]
  end
end

## Protocols-1

#
# Protocol CaesarEncrypt
#
defprotocol CaesarEncrypt do
  def encrypt(string, shift)
  def rot13(string)
end

#
# For charlist CaesarEncrypt
#
defimpl CaesarEncrypt, for: List do
  def encrypt(string, shift) do
    MyList.caesar(string, shift)
  end

  def rot13(string) do
    encrypt(string, 13)
  end
end

#
# For binary CaesarEncrypt
#
defimpl CaesarEncrypt, for: BitString do
  def encrypt(string, shift) do
    to_charlist(string)
    |> CaesarEncrypt.encrypt(shift)
    |> to_string
  end
  def rot13(string) do
    encrypt(string, 13)
  end
end

## Protocols-2

# SCOWL (Spell Checker Oriented Word Lists) get by http://wordlist.aspell.net/
path = "special-hacker.50" # scowl-2017.08.24/final/special-hacker.50
stream = File.stream!(path, [], :line)
wordlist = stream |> Enum.map(fn line -> 
  line
  |> String.downcase
  |> String.trim
end)
wordset = MapSet.new(wordlist)
matchlist = Enum.flat_map(wordlist, fn word -> 
  enctypted = CaesarEncrypt.rot13(word)
  if MapSet.member?(wordset, enctypted) do
    ["rot13(#{word}) === #{enctypted}"]
  else
    []
  end
end)

IO.inspect matchlist

# ["rot13(g) === t", "rot13(k) === x", "rot13(t) === g", "rot13(x) === k",
# "rot13(flap) === sync", "rot13(sync) === flap"]
