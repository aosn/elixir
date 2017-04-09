defmodule MyList do
  def caesar([], _), do: []
  def caesar([head|tail], adding) when head > (122 - adding), do: [head + adding - 26 | caesar(tail, adding)]
  def caesar([head|tail], adding), do: [head + adding | caesar(tail, adding)]
end

IO.inspect("MyList.caesar('ryvkve', 13)")
IO.inspect(MyList.caesar('ryvkve', 13))

