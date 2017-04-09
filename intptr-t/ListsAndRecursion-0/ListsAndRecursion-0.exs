defmodule MyList do
  # summation without accumurator
  def sum([]),            do: 0
  def sum([head | tail]), do: head + sum(tail)
end

#iex(1)> MyList.sum([1,2,3,4,5])
#15
#iex(2)> MyList.sum([11,12,13,14,15])
#65
