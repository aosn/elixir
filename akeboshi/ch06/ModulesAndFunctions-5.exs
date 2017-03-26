defmodule Gcd do
  def gcd(x, 0), do: x
  def gcd(x, y), do: gcd(y, rem(x, y))
end

IO.inspect(Gcd.gcd(5, 0))
IO.inspect(Gcd.gcd(30, 45))
