
defmodule MyList do
    def foldr( _, [], y )        , do: y
    def foldr( f, [ x | xs ], y ), do: foldr( f, x, foldr( f, xs, y ) )
    def foldr( f, x, y )         , do: f.( x, y )

    def flatten( xs ), do: foldr( fn ( x, xs ) -> [ x | xs ] end, xs, [] )
end

IO.inspect MyList.flatten( [] )
# []
IO.inspect MyList.flatten( [ 1 ] )
# [1]
IO.inspect MyList.flatten( [ 1, [ 2, 3, [[4]] ], 5, [[[6]]] ] )
# [1, 2, 3, 4, 5, 6]
IO.inspect MyList.flatten( [ [ [ 1, [], [ [ [ 2, 3 ], [[4]] ], 5, [[[6]]] ] ], 'abcde' ] ] )
# [1, 2, 3, 4, 5, 6, 97, 98, 99, 100, 101]
IO.inspect MyList.flatten( [ 'abcde' ] )
# 'abcde'
