# FizzBuzz 
# 0, 0, a -> FizzBuzz
# 0, a, b -> Fizz
# a, 0 ,b -> Buzz
# a, b, c -> c

fizz_buzz = fn
    0, 0, _a -> "FizzBuzz"
    0, _a, _b -> "Fiz"
    _a, 0 ,_b -> "Buzz"
    _a, _b, c -> c
end

IO.puts fizz_buzz.(0,0,10)
IO.puts fizz_buzz.(0,20,10)
IO.puts fizz_buzz.(4,0,10)
IO.puts fizz_buzz.(3,5,10)
