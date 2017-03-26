defmodule Chop do
  def guess(actual, range = a..b) do
    guess_value = div(a+b, 2)
    IO.puts "Is it #{guess_value}"
    guess_helper(actual, guess_value, range)
  end

  def guess_helper(actual, guess_value, _) when actual == guess_value do
    actual
  end

  def guess_helper(actual, guess_value, _ = _..b) when actual > guess_value do
    guess(actual, (guess_value+1)..b)
  end

  def guess_helper(actual, guess_value, _ = a.._) when actual < guess_value do
    guess(actual, a..(guess_value-1))
  end
end

# $ iex ModulesAndFunctions-6.exs
# iex(1)> Chop.guess(273, 1..1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273
