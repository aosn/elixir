defmodule MyEnum do
  ##
  ## all
  ##
  def all?(enumerable),         do: all?(enumerable, fn x -> !!x end)
  def all?([], _),              do: true
  def all?([head | tail], pred) do 
    if pred.(head) == true do
      all?(tail, pred)
    else
      false
    end
  end

  ##
  ## each
  ##
  def each(enumerable, fun) do
    for e <- enumerable do
      fun.(e)
    end
    :ok # eachは"each(t, (element -> any)) :: :ok"がシグニチャのため:okを返す
  end

  ##
  ## filter
  ##
  def filter([], _),              do: []
  def filter([head | tail], pred) do
    if pred.(head) do
      [head | filter(tail, pred)]
    else
      filter(tail, pred)
    end
  end

  ##
  ## split
  ##
  def split(enumerable, count) do
    if count >= 0 do
      _split_l(enumerable, 0, count, [], [])
    else
      # 要素を逆転して、右側から追加していく
      _split_r(reverse(enumerable), 0, -count, [], [])
    end
  end
  # 左から指定個数の要素を追加してく
  defp _split_l([], _index, _count, acc_l, acc_r) do
    {reverse(acc_l), reverse(acc_r)}
  end
  defp _split_l([head | tail], index, count, acc_l, acc_r) when index < count do
    _split_l(tail, index + 1, count, [head | acc_l], acc_r)
  end
  defp _split_l([head | tail], index, count, acc_l, acc_r) when index >= count do
    _split_l(tail, index + 1, count, acc_l, [head | acc_r])
  end 
  # 右側から指定個数の要素を追加してく
  defp _split_r([], _index, _count, acc_l, acc_r) do
    {acc_l, acc_r}
  end
  defp _split_r([head | tail], index, count, acc_l, acc_r) when index < count do
    _split_r(tail, index + 1, count, acc_l, [head | acc_r])
  end
  defp _split_r([head | tail], index, count, acc_l, acc_r) when index >= count do
    _split_r(tail, index + 1, count, [head | acc_l], acc_r)
  end

  ##
  ## take
  ##
  def take(enumerable, count) do
    if count >= 0 do
      _take_l(enumerable, 0, count, [])
    else
      _take_r(reverse(enumerable), 0, -count, [])
    end
  end
  # 左側から指定個数の要素を取り出す
  defp _take_l([], _index, _count, acc),         do: reverse(acc)
  defp _take_l([head | tail], index, count, acc) do
    if index < count do
      _take_l(tail, index + 1, count, [head | acc])
    else
      reverse(acc)
    end
  end 
  # 右側から指定個数の要素を取り出す
  defp _take_r([], _index, _count, acc),         do: acc
  defp _take_r([head | tail], index, count, acc) do
    if index < count do
      _take_r(tail, index + 1, count, [head | acc])
    else
      acc
    end
  end

  #
  # 補助関数:reverse
  #
  defp reverse(enumerable) do
    _reverse_help(enumerable, [])
  end
  defp _reverse_help([], acc),           do: acc
  defp _reverse_help([head | tail], acc) do
    _reverse_help(tail, [head | acc])
  end
end


# iex(1)> Enum.all?([1,2,3,4,5], &(&1 < 4))
# false
# iex(2)> MyEnum.all?([1,2,3,4,5], &(&1 < 4))
# false
# ----------

# iex(3)> Enum.all?([1,2,3,4,5])
# true
# iex(4)> MyEnum.all?([1,2,3,4,5])
# true
# ----------

# iex(1) > Enum.each(["some", "example"], fn(x) -> IO.puts x end)
# some
# example
# :ok
# iex(2)> MyEnum.each(["some", "example"], fn(x) -> IO.puts x end)
# some
# example
# :ok
# ----------

# iex(1) > Enum.filter(Enum.to_list(1..5), &(&1 < 4))
# [1, 2, 3]
# iex(2) > MyEnum.filter(Enum.to_list(1..5), &(&1 < 4))
# [1, 2, 3]
# ----------

# iex(1)> Enum.split([1, 2, 3], 2)
# {[1, 2], [3]}
# iex(2)> MyEnum.split([1, 2, 3], 2)
# {[1, 2], [3]}
# 
# iex(3)> Enum.split([1, 2, 3], 10)
# {[1, 2, 3], []}
# iex(4)> MyEnum.split([1, 2, 3], 10)
# {[1, 2, 3], []}
#
# iex(5)> Enum.split([1, 2, 3], 0)
# {[], [1, 2, 3]}
# iex(6)> MyEnum.split([1, 2, 3], 0)
# {[], [1, 2, 3]}
#
# iex(7)> Enum.split([1, 2, 3], -1)
# {[1, 2], [3]}
# iex(8)> MyEnum.split([1, 2, 3], -1)
# {[1, 2], [3]}
#
# iex(9)> Enum.split([1, 2, 3], -5)
# {[], [1, 2, 3]}
# iex(10)> MyEnum.split([1, 2, 3], -5)
# {[], [1, 2, 3]}
# ----------

# iex(1)> Enum.take([1, 2, 3], 2)
# [1, 2]
# iex(2)> MyEnum.take([1, 2, 3], 2)
# [1, 2]
#
# iex(3)> Enum.take([1, 2, 3], 10)
# [1, 2, 3]
# iex(4)> MyEnum.take([1, 2, 3], 10)
# [1, 2, 3]
#
# iex(5)> Enum.take([1, 2, 3], 0)
# []
# iex(6)> MyEnum.take([1, 2, 3], 0) 
# []
#
# iex(7)> Enum.take([1, 2, 3], -1)
# [3]
# iex(8)> MyEnum.take([1, 2, 3], -1)
# [3] 
# ----------
