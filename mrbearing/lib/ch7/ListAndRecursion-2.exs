defmodule MyList do
    def max([head|tail]) , do: _max(head,tail)

    defp _max(a,[]) , do: a
    defp _max( a, [head | tail]) when a > head do
        _max(a,tail)
    end
    defp _max(a,[head | tail]) when a <= head do
        _max(head , tail)
    end

end


# 
