defmodule MyList do
  def mapsum([], _func), do: 0
  def mapsum([head|tail], func), do: func.(head) + mapsum(tail, func)
end

IO.inspect("MyList.mapsum([1,2,3], &(&1 * &1))")
IO.inspect(MyList.mapsum([1,2,3], &(&1 * &1)))

