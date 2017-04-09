defmodule MyList do
    def mapsum([], _func) , do: 0
    def mapsum([head | tail ] , func) , do: func.(head)+ mapsum(tail, func)
end

# 
# iex(1)> c "ListAndRecursion-1.exs"
# [MyList]
# iex(2)> MyList.mapsum([1,2,3], &(&1 * &1))
# 14