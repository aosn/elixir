defmodule MyList do
  def max([]), do: 0
  def max([head|tail]), do: _max(tail, head)

  defp _max([], max_num), do: max_num
  defp _max([head|tail], max_num) when head > max_num, do: _max(tail, head)
  defp _max([_head|tail], max_num), do: _max(tail, max_num)
end

IO.inspect("MyList.max([1,2,3])")
IO.inspect(MyList.max([3,-1,100,50,70,-30]))

