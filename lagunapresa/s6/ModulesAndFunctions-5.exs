defmodule Gcd do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

# iex(1)> Gcd.gcd(99, 33)
# 33
# iex(2)> Gcd.gcd(99, 22)
# 11
# iex(3)> Gcd.gcd(22, 99)
# 11
