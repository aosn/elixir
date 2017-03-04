fizz_buzz_echo = fn
  0, 0, _ -> "FizzBuzz"
  0, _, _ -> "Fizz"
  _, 0, _ -> "Buzz"
  _, _, c -> c
end

#iex> fizz_buzz_echo.(0,0,0)
#"FizzBuzz"
#iex> fizz_buzz_echo.(0,1,0) 
#"Fizz"
#iex> fizz_buzz_echo.(1,0,0)
#"Buzz"
#iex> fizz_buzz_echo.(1,1,0)
#0
#iex> 
