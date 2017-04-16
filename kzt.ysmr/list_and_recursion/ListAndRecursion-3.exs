
defmodule MyList do
    def caesar( [], _ ), do: []
    def caesar( [ x | xs ], y ), do: [ loop( x, y ) | caesar( xs, y ) ]

    defp loop( x, y ), do: rem( ( ( x - 97 )  + y ), 26 ) + 97
end

IO.puts MyList.caesar( '', 0 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 0 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 1 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 2 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 3 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 4 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 5 )

