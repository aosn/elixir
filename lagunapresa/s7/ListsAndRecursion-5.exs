defmodule MyEnum do
  def all?([h|tail], pred) do
    if pred.(h) do
      all?(tail, pred)
    else
      false
    end
  end
  def all?([], _pred), do: true

  def each([h|tail], fun) do
    fun.(h)
    each(tail, fun)
  end
  def each([], _fun) do end

  def filter(xs, pred), do: filter(xs, [], pred)
  defp filter([], acc, _pred), do: acc
  defp filter([h|tail], acc, pred) do
    if pred.(h) do
      filter(tail, acc ++ [h], pred)
    else
      filter(tail, acc, pred)
    end
  end

  def split(xs, count), do: split(xs, [], count)
  defp split([], acc, _count), do: {acc, []}
  defp split(xs, acc, count) when count <= 0, do: {acc, xs}
  defp split([h|tail], acc, count), do: split(tail, acc ++ [h], count - 1)

  def take(xs, count) do
    {first, _} = split(xs, count)
    first
  end
end

# iex(1)> c "ListsAndRecursion-5.exs"
# [MyEnum]
# iex(2)> MyEnum.all?([1,2,3,4], &(&1 < 4))
# false
# iex(3)> MyEnum.all?([1,2,3,4], &(&1 <= 4))
# true

# iex(6)> MyEnum.each([1,2,3], &(IO.puts(&1)))
# 1
# 2
# 3
# nil

# iex(10)> MyEnum.filter([1,2,3,4], &(&1 > 2))
# [3, 4]

# iex(19)> MyEnum.split([1,2,3,4], 0)
# {[], [1, 2, 3, 4]}
# iex(20)> MyEnum.split([1,2,3,4], 1)
# {[1], [2, 3, 4]}
# iex(21)> MyEnum.split([1,2,3,4], 4)
# {[1, 2, 3, 4], []}
# iex(22)> MyEnum.split([1,2,3,4], 5)
# {[1, 2, 3, 4], []}

# iex(25)> MyEnum.take([1,2,3,4], 1)
# [1]
