defmodule MyList do
  def sum([]), do: 0
  def sum([h | tail]), do: h + sum(tail)
end

# iex(1)> c "ListsAndRecursion-0.exs"
# [MyList]
# iex(2)> MyList.sum([1,2,3,4])
# 10
# iex(3)>
