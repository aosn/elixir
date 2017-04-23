defmodule MyList do

    def span( x, y ) when x >= y, do: :undefined
    def span( x, y ) when x == y - 1, do: [ x ]
    def span( x, y ), do: [ x | span( x + 1, y ) ]
end

IO.inspect MyList.span( 0, -1 )
IO.inspect MyList.span( 0, 0 )
IO.inspect MyList.span( 0, 1 )
IO.inspect MyList.span( 0, 10 )
