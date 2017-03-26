defmodule Guess do
  def guess(a, s..e) when a < s or e < a, do: IO.puts("error")
  def guess(a, s..e) do
    x = div(s + e, 2)
    IO.puts("Is it #{x}")
    cond do
      x < a -> guess(a, (x + 1)..e)
      a < x -> guess(a, s..(x - 1))
      true  -> x
    end
  end
end

# iex(1)> Guess.guess(42, 1..100)
# Is it 50
# Is it 25
# Is it 37
# Is it 43
# Is it 40
# Is it 41
# Is it 42
# 42
