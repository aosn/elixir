defmodule Chop do
  def guess(actual, left..right) do
    guess_helper(actual, div(left + right, 2), left..right)
    |> Enum.each(&(IO.puts "Is it #{&1}"))
  end

  def guess_helper(actual, guess, _) when actual === guess do
    [guess]
  end
  def guess_helper(actual, guess, left.._) when actual < guess do
    [guess] ++ guess_helper(actual, div(left + guess, 2), left..guess)
  end
  def guess_helper(actual, guess, _..right) when actual > guess do
    [guess] ++ guess_helper(actual, div(guess + right, 2), guess..right)
  end
end
