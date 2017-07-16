defmodule MyModule do
    def span(from, to) when from > to, do: []
    def span(from, to), do: [ from | span(from+1, to) ]

    def prime([head | tail]) do
        IO.inspect head
        # prime(prime_list(head, tail))
        prime( for x <- tail, rem(x , head) != 0 , do: x  )
    end
    def prime(n) do
        IO.inspect n
        prime(span(2,n))
    end
    
    

    # def prime_list (n , list), do: for x <- list, rem(x , n) != 0 , do: x

end

list = MyModule.span(2,20)
IO.inspect list
IO.inspect for x <- list, rem(x , 2) != 0 , do: x 
IO.inspect MyModule.prime(list)

