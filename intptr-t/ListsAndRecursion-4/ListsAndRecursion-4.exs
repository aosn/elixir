defmodule MyList do
  def span(from, to) when from > to, do: []
  def span(from, to)               , do: [from | span(from+1, to)]
end

# iex(1)> MyList.span(1,10)
# [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
# iex(2)> MyList.span(-3,-1)
# [-3, -2, -1]
# iex(3)> MyList.span(10, 1)
# []
# iex(4)> MyList.span(-1, -3)
# []
# iex(5)> MyList.span(1, 1) 
# [1]
