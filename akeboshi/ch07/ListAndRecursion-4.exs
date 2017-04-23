defmodule MyList do
  def span(from, to) when from > to, do: span(to, from)
  def span(from, to) when from == to, do: [to]
  def span(from, to), do: [from | span(from + 1, to)]
end

IO.inspect("MyList.span(1,3) #=> [1,2,3]")
IO.inspect(MyList.span(1,3))
IO.inspect("MyList.span(3,1) #=> [1,2,3]")
IO.inspect(MyList.span(3,1))
IO.inspect("MyList.span(1,1) #=> [1]")
IO.inspect(MyList.span(1,1))

