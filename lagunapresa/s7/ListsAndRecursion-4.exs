defmodule MyList do
  def span(from, to) when from > to, do: raise "Illigal Arguments: from > to"
  def span(from, to), do: _span([], from, to)
  defp _span(acc, from, cur) when from == cur, do: [ from | acc ]
  defp _span(acc, from, cur), do: _span([ cur | acc ], from, cur - 1)
end

# iex(1)> c "ListsAndRecursion-4.exs"
# [MyList]
# iex(2)> MyList.span(-1,3)
# [-1, 0, 1, 2, 3]
# iex(3)> MyList.span(3,-1)
# ** (RuntimeError) Illigal Arguments: from > to
#     ListsAndRecursion-4.exs:2: MyList.span/2
