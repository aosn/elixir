
defmodule MyList do
    def sum( [] ), do: 0
    def sum( [ head | tail ] ), do: head + sum( tail )
end

IO.puts MyList.sum( [] )
IO.puts MyList.sum( [ 1, 2, 3 ] )




