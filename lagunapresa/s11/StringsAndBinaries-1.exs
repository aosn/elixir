defmodule MyString do
  def printable?(chars) do
    # found ? followed by codepoint 0x20 (space), please use \s instead
    new = chars -- Enum.to_list ?\s..?~
    if new == chars do
      [] == new
    else
      printable?(new)
    end
  end
end

# iex(14)> MyString.printable? [97, 67]
# true
# iex(15)> MyString.printable? [97, 67,127]
# false
