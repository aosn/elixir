
defmodule Summation do
  def sum(0), do: 0
  def sum(n), do: n + sum(n-1)
end

# $ iex ModulesAndFunctions-4.exs 
# iex(1)> Summation.sum(1)
# 1
# iex(2)> Summation.sum(2)
# 3
# iex(3)> Summation.sum(3)
# 6
# iex(4)> Summation.sum(100)
# 5050 
