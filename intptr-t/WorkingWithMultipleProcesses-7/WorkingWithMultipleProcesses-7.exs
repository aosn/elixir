defmodule Parallel do
  import :timer, only: [ sleep: 1 ]

  def pmap(collection, fun) do
    me = self()
    max_elem = Enum.max(collection)
    collection
    |> Enum.map(fn (elem) -> 
        spawn_link fn -> (
          # Larger numbers are shorter, and smaller numbers are longer sleep
          sleep (max_elem * max_elem) - (elem * elem)
          send me, { self(), fun.(elem) }
        ) end
      end)
    |> Enum.map(fn (pid) -> 
        receive do { ^pid, result } -> result end
        #receive do { _pid, result } -> result end
      end)
  end
end

# sleepを使わない場合
#  * ^pidのままの実行結果
#     iex(1)> Parallel.pmap 1..10, &(&1 * &1)
#     [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
#
#  * ^pidを_pidに変えた実行結果
#     iex(1)> Parallel.pmap 1..10, &(&1 * &1)
#     [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# sleepを使った場合
#  * ^pidのままの実行結果
#     iex(1)> Parallel.pmap 1..10, &(&1 * &1)
#     [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
#
#  * ^pidを_pidに変えた実行結果
#     iex(1)> Parallel.pmap 1..10, &(&1 * &1)
#     [100, 81, 64, 49, 36, 25, 16, 9, 4, 1]
