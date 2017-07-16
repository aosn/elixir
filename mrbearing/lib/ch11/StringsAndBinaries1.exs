defmodule MyString do
    def isAscii?([]), do: true
    def isAscii?([head | tail])do
        isAsciiChar?(head) and isAscii?(tail)
    end 
    def isAsciiChar?(char) do
        IO.puts ?c
        (32 <= ?c  and ?c <= 126)
    end
end

IO.puts "*******"
IO.puts MyString.isAsciiChar?('a')
IO.puts MyString.isAsciiChar?('b')
IO.puts MyString.isAsciiChar?('あ')
IO.puts MyString.isAsciiChar?('!')
IO.puts "*******"
IO.puts MyString.isAscii?('test')
IO.puts MyString.isAscii?('てすと')
IO.puts MyString.isAscii?('!"#$%&')


