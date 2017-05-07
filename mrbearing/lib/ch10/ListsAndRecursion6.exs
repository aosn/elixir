defmodule MyList do
    
    def flatten([]), do: []
    def flatten([head | tail]) do
        n_head = _flatten(head)
        [n_head]++flatten( tail )
    end

    defp _flatten(num), do: num
    defp _faltten( [ head | tail ] ) do
        flatten( [ head | tail ] )
    end
end


IO.inspect MyList.flatten([1,[2,3,4],5,[[[6]]])



