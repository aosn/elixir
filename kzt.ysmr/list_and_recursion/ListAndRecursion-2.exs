
defmodule MyList do
    def max( list ), do: reduce( list, 0, fn ( x, y ) -> _max( x, y ) end )

    def reduce( [], default, op ), do: default
    def reduce( [ head | tail ], default, op ), do: op.( head, reduce( tail, default, op ) )

    defp _max( x, y ) when x < y, do: y
    defp _max( x, y ), do: x
end

IO.puts MyList.max( [] )
IO.puts MyList.max( [ 1, 2, 3, 1 ] )

