
defmodule FizzBuzz do
    
    def upto(n) when n > 0 do
        1..n |>Enum.map(&fizzbuzz/1) 
    end

    defp fizzbuzz(n) do
        case {rem(n,3)==0 , rem(n,5)==0} do
            {true,true} -> "FizzBuzz"  
            {true,false} -> "Fizz"  
            {false, true} -> "Buzz"
            _ ->  n
        end  
    end
end


IO.inspect FizzBuzz.upto(100)