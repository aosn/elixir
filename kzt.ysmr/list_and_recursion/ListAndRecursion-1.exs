
defmodule MyList do
    def mapsum( [], f ), do: 0
    def mapsum( [ head | tail ], f ), do: f.( head ) + mapsum( tail, f )
end

IO.puts MyList.mapsum( [], fn (n) -> n + 1 end )
IO.puts MyList.mapsum( [ 1, 2, 3 ], fn (n) -> n + 1 end )

