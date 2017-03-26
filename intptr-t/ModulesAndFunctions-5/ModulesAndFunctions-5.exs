defmodule Gcd do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# 
# $ iex ModulesAndFunctions-5.exs 
# iex(1)> Gcd.gcd(10, 3)
# 1
# iex(2)> Gcd.gcd(10, 2)
# 2
# iex(3)> Gcd.gcd(10, 5)
# 5
#
