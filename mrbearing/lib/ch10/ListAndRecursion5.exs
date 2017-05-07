defmodule MyEnum do
    def all([], _fun), do: true
    def all([ head | tail ], fun) do
        if fun.(head) do
            all(tail, fun)
        else
            false
        end
    end


    def filter([], _fun), do: []
    def filter([ head | tail ], fun) do
        if fun.(head) do
            [head]++filter(tail, fun)
        else
            []++filter(tail, fun) 
        end
    end

    def each([] , _fun ), do: []
    def each([head | tail], fun ) ,do: [fun.(head)] ++ each(tail,fun)


    def split(list, 0) , do: [[] , list]
    def split([], _cont) , do: []
    def split([head| tail], count) do
        [first, rest] = split(tail,count-1)
        [[head | first], rest]
    end

    def take(list, 0) , do: []
    def take([], _count) , do: []
    def take([head | tail ] , count ) do
        ret = take(tail,count-1)
        [head | ret]
    end

end

list = [1,2,3,4,5]


IO.inspect MyEnum.all([1,2,3,4] ,&( &1<5 ))       # true
IO.inspect MyEnum.all(list , &( &1>5 ))      # false

IO.inspect MyEnum.filter(list, &( &1>2 ) )
IO.inspect MyEnum.each(list, &(&1 * 2 ) )

IO.inspect MyEnum.split(list,3)
IO.inspect MyEnum.take(list,3)
