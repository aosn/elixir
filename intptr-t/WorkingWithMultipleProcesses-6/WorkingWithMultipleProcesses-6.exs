defmodule Parallel do
  def pmap(collection, fun) do
    me = self()
    collection
    |> Enum.map(fn (elem) -> 
        spawn_link fn -> (send me, { self(), fun.(elem) }) end
      end)
    |> Enum.map(fn (pid) -> 
        receive do { ^pid, result } -> result end
      end)
  end
end

# meを使った実行結果
# iex(1)> Parallel.pmap 1..10, &(&1 * &1)
# [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

# Q. なぜ、ここで変数(me)に分けたのだろうか
# A. 子プロセス内のself()は子プロセス自信のPIDを表しており、
#    親プロセスにメッセージを返せなくなってしまう。
#    そのため、変数meに親プロセスのPIDを束縛するために分けている