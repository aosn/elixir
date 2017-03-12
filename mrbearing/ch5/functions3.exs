say_fizz_buzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fiz"
    _, 0 ,_ -> "Buzz"
    _, _, c -> c
end

fizzbuzz = fn n -> say_fizz_buzz.(rem(n,3) , rem(n,5), n) end


IO.puts fizzbuzz.(10)
IO.puts fizzbuzz.(11)
IO.puts fizzbuzz.(12)
IO.puts fizzbuzz.(13)
IO.puts fizzbuzz.(14)
IO.puts fizzbuzz.(15)
IO.puts fizzbuzz.(16)
