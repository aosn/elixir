
defmodule MyList do
    def max( [] ), do: 0
    def max( [ head | tail ] ), do: _max( head, max( tail ) )

    defp _max( x, y ) when x < y, do: y
    defp _max( x, y ), do: x
end

IO.puts MyList.max( [] )
IO.puts MyList.max( [ 1, 2, 3, 1 ] )


