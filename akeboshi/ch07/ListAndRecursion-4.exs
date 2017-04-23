defmodule MyList do
  def span(from, to), do: _span(from, to)
  defp _span(from, to) when from > to, do: _span(to, from)
  defp _span(from, to) when from == to, do: [to]
  defp _span(from, to), do: [from | _span(from + 1, to)]
end

IO.inspect("MyList.span(1,3) #=> [1,2,3]")
IO.inspect(MyList.span(1,3))
IO.inspect("MyList.span(3,1) #=> [1,2,3]")
IO.inspect(MyList.span(3,1))
IO.inspect("MyList.span(1,1) #=> [1]")
IO.inspect(MyList.span(1,1))

