

defmodule MyList do
    def all?( [], _ ), do: :true
    def all?( [ x | xs ], f ), do: f.( x ) && all?( xs, f )
end



