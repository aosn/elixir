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
    to_char_list(string)
    |> CaesarEncrypt.encrypt(shift)
    |> to_string
  end
  def rot13(string) do
    encrypt(string, 13)
  end
end

#
# example code
#
IO.inspect CaesarEncrypt.encrypt('ryvkve', 13)
IO.inspect CaesarEncrypt.rot13('ryvkve')
IO.inspect CaesarEncrypt.encrypt("ryvkve", 13)
IO.inspect CaesarEncrypt.rot13("ryvkve")

IO.inspect CaesarEncrypt.encrypt('z', 1)
IO.inspect CaesarEncrypt.encrypt("z", 1)
