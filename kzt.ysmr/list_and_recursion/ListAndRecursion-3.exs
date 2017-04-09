
defmodule MyList do
    def caesar( [], n ), do: []
    def caesar( [ head | tail ], n ), do: [ helper( head, n ) | caesar( tail, n ) ]

    defp helper( x, n ) when 122 < x + n, do: 97
    defp helper( x, n ), do: x + n
end

IO.puts MyList.caesar( '', 0 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 0 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 1 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 2 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 3 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 4 )
IO.puts MyList.caesar( 'abcdefghijklnmopqrstuvwxyz', 5 )

