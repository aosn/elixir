defmodule MyList do
  def mapsum([], _), do: 0
  def mapsum([h | tail], f), do: f.(h) + mapsum(tail, f)
end

# iex(2)> MyList.mapsum([1,2,3,4], fn n -> n * n end)
# 30
# iex(3)>
