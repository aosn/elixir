fizzbuzz = fn 0, 0, _ -> "FizzBuzz"
              0, _, _ -> "Fizz"
              _, 0, _ -> "Buzz"
              _, _, a -> a
	   end

test = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

IO.puts(test.(10))
IO.puts(test.(11))
IO.puts(test.(12))
IO.puts(test.(13))
IO.puts(test.(14))
IO.puts(test.(15))
IO.puts(test.(16))
