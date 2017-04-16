
defmodule MyList do
    def max( xs ), do: reduce( xs, 0, fn ( x, y ) -> _max( x, y ) end )

    def reduce( [], x0, _ ), do: x0
    def reduce( [ x | xs ], x0, f ), do: f.( x, reduce( xs, x0, f ) )

    defp _max( x, y ) when x < y, do: y
    defp _max( x, _ ), do: x
end

IO.puts MyList.max( [] )
IO.puts MyList.max( [ 1, 2, 3, 1 ] )

