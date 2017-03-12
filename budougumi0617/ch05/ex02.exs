fizzbuzz = fn
    0, 0, _ -> "FizzBuzz"
    0, _, _ -> "Fizz"
    _, 0, _ -> "Buzz"
    _, _, i -> i
end

IO.Puts fizzbuzz.(0,2,15)
