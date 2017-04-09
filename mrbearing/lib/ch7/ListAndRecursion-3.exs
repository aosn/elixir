# a = 97
# z = 122


defmodule MyList do
    def caesar([],_n) , do: []

    def caesar([head | tail], n)when head + n > 122 do
         [head + n - 26 | caesar(tail, n)]
    end

    def caesar([head | tail], n) do
         [head + n | caesar(tail,n) ]
    end
    
end

IO.puts MyList.caesar('ryvkve', 13) # => elixir
