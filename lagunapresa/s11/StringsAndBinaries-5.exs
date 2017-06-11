defmodule Pyramid do
  def center(li) do
    max = li |> maxlen
    Enum.each(li, &(padding(&1, max) |> IO.puts))
  end
  defp maxlen(ss), do: Enum.max(Enum.map(ss, &String.length/1))
  defp padding(s, max) do
    len = max - String.length(s)
    left = div(len, 2)
    right = len - left
    String.duplicate(" ", left) <> s <> String.duplicate(" ", right)
  end
end

# iex(1)> Pyramid.center(["a", "abc", "abcd", "abcde"])
#   a
#  abc
# abcd
# abcde
# :ok

# iex(2)> Pyramid.center(["a", "åbç", "abcd", "abcde"])
#   a
#  åbç
# abcd
# abcde
# :ok
