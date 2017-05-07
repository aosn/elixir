defmodule MyEnum do
  def all?([], _), do: true
  def all?([head|list], func) do
    if func.(head) do
      all?(list, func)
    else
      false
    end
  end

  def all2?([], _), do: false
  def all2?(list, func), do: all2?(list, func, true)
  defp all2?([head|list], func, true), do: all2?(list, func, func.(head))
  defp all2?(_, _, condition), do: condition
  # defp all2?([], _, true), do: true
  # defp all2?(_, _, _), do: false

  def filter([], _), do: []
  def filter([head|tail], func) do
    if func.(head) do
      [head | filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def all_filter_ver?(list, func), do: list == filter(list, func)
  
  def each([head | []], func), do: func.(head)
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def split(list, count) do
    head = take(list, count)
    {head, list -- head}
  end

  def take_tail(list, 0), do: list
  def take_tail([_ | tail], count), do: take_tail(tail, count-1)

  def take(_, 0), do: []
  def take([head | tail], count), do: [head | take(tail, count-1)]
end

list = Enum.to_list 1..5
IO.inspect(MyEnum.all?(list, &(&1 < 6)))
IO.inspect(MyEnum.all2?(list, &(&1 < 6)))
IO.inspect(MyEnum.all_filter_ver?(list, &(&1 < 6)))

require Integer
IO.inspect(MyEnum.filter(list, &Integer.is_even/1))
MyEnum.each(list, &IO.puts/1)
IO.inspect(MyEnum.split(list, 3))
IO.inspect(MyEnum.take(list, 3))
IO.inspect(MyEnum.take_tail(list, 3))
