defmodule Times do
  def double(n), do: n * 2
  def triple(n), do: n * 3
  def quadruple(n), do: double(n) + double(n)
end

# $ iex ModulesAndFunctions-1.exs 
# iex(1)> Times.triple(3)
# 9
# iex(2)> Times.quadruple(3)
# 12
# $ iex
# iex(1)> c "ModulesAndFunctions-1.exs"
# [Times]
# iex(2)> Times.triple(3)
# 9
# iex(3)> Times.quadruple(4)
# 16
