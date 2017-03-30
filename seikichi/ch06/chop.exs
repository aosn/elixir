defmodule Chop do
  def guess(actual, left..right) do
    helper(actual, div(left + right, 2), left..right)
    |> Enum.each(&(IO.puts "Is it #{&1}"))
  end

  def helper(actual, actual, _), do: [actual]
  def helper(actual, guess, left.._) when actual < guess do
    [guess | helper(actual, div(left + guess - 1, 2), left..guess-1)]
  end
  def helper(actual, guess, _..right) when actual > guess do
    [guess | helper(actual, div(guess + 1 + right, 2), guess+1..right)]
  end
end
