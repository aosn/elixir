defmodule MyStringUtil do
  def printable_ASCII?([]), do: true
  def printable_ASCII?([head | tail])
    when ?\s <= head and head <= ?~ do
      printable_ASCII?(tail)
  end
  def printable_ASCII?(_), do: false
end

IO.inspect("MyStringUtil.printable_ASCII?('abc')")
IO.inspect(MyStringUtil.printable_ASCII?('abc'))
IO.inspect("MyStringUtil.printable_ASCII?(123)")
IO.inspect(MyStringUtil.printable_ASCII?(123))
IO.inspect("MyStringUtil.printable_ASCII?('あいう')")
IO.inspect(MyStringUtil.printable_ASCII?('あいう'))
