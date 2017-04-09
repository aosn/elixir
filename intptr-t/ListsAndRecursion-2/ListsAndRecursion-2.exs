defmodule MyList do
  def max(list),            do: _max(list)
  defp _max([head | tail]), do: _max(tail, head)

  defp _max([], max_value), do: max_value
  defp _max([head | tail], max_value) when head > max_value do
    _max(tail, head)
  end
  defp _max([head | tail], max_value) when head <= max_value do
    _max(tail, max_value)
  end
end

# iex(1)> MyList.max([1, 2, 3])
# 3
# iex(2)> MyList.max([3, 2, 1])
# 3
# iex(3)> MyList.max([3, 4, 1])
# 4
# iex(4)> MyList.max([3, 3, 3])
# 3
# iex(5)> MyList.max([-1, -2, -3])
# -1
