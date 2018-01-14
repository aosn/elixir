defmodule MyEnum do
  # each(t(), (element() -> any())) :: :ok
  def each(enumerable, fun) do 
      # (element(), any()) -> any()
      each_helper = fn element, _acc ->
        fun.(element)
        {:cont, nil}
      end
      Enumerable.reduce(enumerable, {:cont, nil}, each_helper)
      :ok
  end

  # filter(t(), (element() -> as_boolean(term()))) :: list()
  def filter(enumerable, fun) do
    # (element(), any()) -> any()
    filter_helper = fn element, acc ->
      is_true = fun.(element)
      if is_true do
        {:cont, [element | acc]}
      else
        {:cont, acc}
      end
    end
    {:done, result} = Enumerable.reduce(enumerable, {:cont, []}, filter_helper)
    Enum.reverse(result)
  end
end

list = [1, 2, 3, 4]
dict = %{a: 1, b: 2, c: 3, d: 4}

# each
#Enum.each(list, &(IO.inspect &1*&1))
#MyEnum.each(list, &(IO.inspect &1*&1))
#Enum.each(dict, fn {k ,v} -> IO.inspect "#{k} => #{v}" end)
#MyEnum.each(dict, fn {k ,v} -> IO.inspect "#{k} => #{v}" end)

# 1
# 4
# 9
# 16
# 1
# 4
# 9
# 16
# "a => 1"
# "b => 2"
# "c => 3"
# "d => 4"
# "a => 1"
# "b => 2"
# "c => 3"
# "d => 4"

# filter
require Integer
IO.inspect Enum.filter(list, fn e -> Integer.is_odd(e) end)
IO.inspect MyEnum.filter(list, fn e -> Integer.is_odd(e) end)
IO.inspect Enum.filter(dict, fn {_k, v} -> Integer.is_odd(v) end)
IO.inspect MyEnum.filter(dict, fn {_k, v} -> Integer.is_odd(v) end)

# [1, 3]
# [1, 3]
# [a: 1, c: 3]
# [a: 1, c: 3]
