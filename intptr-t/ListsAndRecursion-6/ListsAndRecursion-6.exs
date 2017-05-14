defmodule MyList do
  def flatten(list), do: _flatten(list, [])

  defp _flatten([], acc), do: Enum.reverse(acc)
  # [[],c]の形式にマッチさせる
  #   tail:  上記 c に対応する
  defp _flatten([[] | tail], acc) do
    _flatten(tail, acc)
  end
  # 1) [[a,b],c]の形式にマッチさせる
  #   head : 上記 [a, b]に対応させ
  #          aと[b]に分解する
  #   tail : 上記 c に対応する
  # 2) [[a],c]の形式にマッチさせる
  #   head : 上記 [a]に対応させ
  #          aと[]に分解する
  #   tail : 上記 c に対応する
  defp _flatten([head | tail], acc) when is_list(head) do
    cdr = rest(head)
    if cdr === [] do
      _flatten([first(head) | tail], acc)
    else
      _flatten([first(head), cdr | tail], acc)
    end
  end
  # [a,b]の形式にマッチさせる
  #   aをaccに追加し、bについて再帰する
  defp _flatten([head | tail], acc) do
    _flatten(tail, [head | acc])
  end

  defp first([head | _tail]), do: head
  defp rest([_head | tail]),  do: tail
end


# iex> MyList.flatten([1, [2, 3, [4]], 5, [[6]]])
# [1, 2, 3, 4, 5, 6]
# iex> MyList.flatten([[[]], 1, [2, 3, [4]], 5, [[6]]])
# [1, 2, 3, 4, 5, 6]
# iex> MyList.flatten([[], 1, [2, 3, [4]], 5, [[6]], [[]]])
# [1, 2, 3, 4, 5, 6]
# iex> MyList.flatten([[], 1, [2, 3, [4]],[[[]]],5, [[6]], [[]]])
# [1, 2, 3, 4, 5, 6]
