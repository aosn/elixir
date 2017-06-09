defmodule Chars do
    @white_space 32
    def is_printable_ascii?([]), do: true
    def is_printable_ascii?([head|tail])
        when (@white_space  <= head) and (head <= ?~) do
            is_printable_ascii(tail)
    end
    def is_printable_ascii?(_), do: false
end

# iex(1)> Chars.is_printable_ascii?('abc')
# true
# iex(2)> Chars.is_printable_ascii?('abc\n')
# false
# iex(3)> Chars.is_printable_ascii?('あabc')
# false
# iex(4)> Chars.is_printable_ascii?(32)
# false
# iex(5)> Chars.is_printable_ascii?([32])
# true
# iex(6)> Chars.is_printable_ascii?("abc")
# false
