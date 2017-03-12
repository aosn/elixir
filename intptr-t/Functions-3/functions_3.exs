# This file continuation of the "functions_2.exs"

fizz_buzz = fn
  n -> fizz_buzz_echo.(rem(n, 3), rem(n, 5), n)
end

IO.puts fizz_buzz.(10) #=> "Buzz"
IO.puts fizz_buzz.(11) #=> 11
IO.puts fizz_buzz.(12) #=> "Fizz"
IO.puts fizz_buzz.(13) #=> 13
IO.puts fizz_buzz.(14) #=> 14
IO.puts fizz_buzz.(15) #=> "FizzBuzz"
IO.puts fizz_buzz.(16) #=> 16
