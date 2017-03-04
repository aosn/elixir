# This file continuation of the "functions_2.exs"

fizz_buzz = fn
  n -> fizz_buzz_echo.(rem(n, 3), rem(n, 5), n)
end

fizz_buzz.(10) #=> "Buzz"
fizz_buzz.(11) #=> 11
fizz_buzz.(12) #=> "Fizz"
fizz_buzz.(13) #=> 13
fizz_buzz.(14) #=> 14
fizz_buzz.(15) #=> "FizzBuzz"
fizz_buzz.(16) #=> 16
