defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadtriple(n), do: double(n) + double(n)
end

#
# $ iex ModulesAndFunctions-3.exs 
# iex(1)> Times.quadtriple(5)
# 20
# iex(2)> Times.quadtriple(100)
# 400
#