fizzbuzz = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, _, n -> n
end

f = fn n -> fizzbuzz.(rem(n, 3), rem(n, 5), n) end

IO.puts(f.(10))
IO.puts(f.(11))
IO.puts(f.(12))
IO.puts(f.(13))
IO.puts(f.(14))
IO.puts(f.(15))
IO.puts(f.(16))
IO.puts(f.(17))
