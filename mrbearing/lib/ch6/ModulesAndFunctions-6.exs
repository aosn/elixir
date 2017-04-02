defmodule Chop do
  def guess(actual, range = l..h) do 
    g = div(l+h, 2)
    IO.puts "Is it #{g}"
    p_guess(actual, g, range)
  end
  defp p_guess(actual,actual, _), do: IO.puts("#{actual}")
  defp p_guess(actual, g, _l..h) when g < actual, do: guess(actual, g+1..h)
  defp p_guess(actual, g, l.._h) when g > actual, do: guess(actual, l..g-1)
end



# Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> c "lib/ch6/ModulesAndFunctions-6.exs"
# [Chop]
# iex(2)> Chop.guess(273,1..1000)
# Is it 500
# Is it 250
# Is it 375
# Is it 312
# Is it 281
# Is it 265
# Is it 273
# 273
# :ok
# iex(3)>