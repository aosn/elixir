defmodule Sum do
  def sum(1), do: 1
  def sum(n), do: n + sum(n - 1)
end

# iex(1)> Sum.sum 1
# 1
# iex(2)> Sum.sum 4
# 10
