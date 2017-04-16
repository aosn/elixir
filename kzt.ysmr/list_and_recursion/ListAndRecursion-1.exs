
defmodule MyList do
    def mapsum( [], _ ), do: 0
    def mapsum( [ x | xs ], f ), do: f.( x ) + mapsum( xs, f )
end

IO.puts MyList.mapsum( [], fn ( x ) -> x + 1 end )
IO.puts MyList.mapsum( [ 1, 2, 3 ], fn ( x ) -> x + 1 end )

