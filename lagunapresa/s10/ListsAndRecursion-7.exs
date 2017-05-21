defmodule MyList do
  def span(from, to) when from > to, do: raise "Illigal Arguments: #{from} > #{to}"
  def span(from, to), do: _span([], from, to)
  defp _span(acc, from, cur) when from == cur, do: [ from | acc ]
  defp _span(acc, from, cur), do: _span([ cur | acc ], from, cur - 1)
end

defmodule Prime do
  import Integer
  def primes_to(a) when not is_number(a), do: raise "Illigal Argument: Not a number"
  def primes_to(a) when a < 2, do: raise "Illigal Argument: #{a} < 2"
  def primes_to(a), do: for n <- MyList.span(2, a), is_prime?(n), do: n
  defp is_prime?(2), do: true
  defp is_prime?(n) when is_even(n), do: false
  defp is_prime?(n), do: MyList.span(2, n-1) |> Enum.all? &(rem(n, &1) != 0)
end

# iex(7)> Prime.primes_to(50)
# [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47]
