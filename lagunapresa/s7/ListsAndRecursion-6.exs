defmodule Flatten do
  def flatten(xs), do: flatten(xs, [])
  defp flatten([], acc), do: acc
  defp flatten([h|tail], acc), do: flatten(h, acc) ++ flatten(tail, [])
  defp flatten(x, acc), do: acc ++ [x]
end

# iex(27)> Flatten.flatten([1,[2,3,[4]],5,[[[6]]]])
# [1, 2, 3, 4, 5, 6]
