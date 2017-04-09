defmodule MyList do
  def caesar(list, n) do
    _caesar(list, n)
  end

  defp _caesar([], _n), do: []
  defp _caesar([head | tail], n) do
    # 'a' := 97
    # total lower-case letter is 26
    [rem(head + n - 97, 26) + 97 | _caesar(tail, n)]
  end
end

# iex(1)> MyList.caesar('ryvkve', 13)
# 'elixir'
# iex(2)> MyList.caesar('abc', 1)
# 'bcd'
# iex(3)> MyList.caesar('abc', 25)
# 'zab'
# iex(4)> MyList.caesar('abc', 0) 
# 'abc'
# iex(5)> MyList.caesar('abc', 26)
# 'abc'
# iex(5)> MyList.caesar('abc', 26*2)
# 'abc'