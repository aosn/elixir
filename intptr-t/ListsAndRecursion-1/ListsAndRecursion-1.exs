defmodule MyList do
  def mapsum([], _fun),           do: 0
  def mapsum([head | tail], fun), do: fun.(head) + mapsum(tail, fun)
end

# iex(1)> MyList.mapsum [1, 2, 3], &(&1 * &1)
# 14
