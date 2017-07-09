
defmodule FizzBuzz do
  def fizzbuzz( x ) do
    case { rem( x, 3 ), rem( x, 5 ) } do
      { 0, 0 } -> "FizzBuzz"
      { 0, _ } -> "Fizz"
      { _, 0 } -> "Buzz"
      { _, _ } -> Integer.to_string( x )
    end
  end
end

0..100 |> Enum.map( &( FizzBuzz.fizzbuzz( &1 ) <> "\n" ) ) |> IO.puts
