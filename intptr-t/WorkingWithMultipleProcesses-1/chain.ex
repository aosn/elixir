defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> 
        send next_pid, n + 1
    end
  end

  def create_processes(n) do 
    last = Enum.reduce 1..n, self(),
            fn (_, send_to) -> 
              spawn(Chain, :counter, [send_to])
            end

            # 0を最後に作ったプロセスへ送り、カウントを開始
    send last, 0

    # 結果が戻ってくるまで待つ
    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# 
# $ elixir -r chain.ex -e "Chain.run(10)"
# $ elixir -r chain.ex -e "Chain.run(100)"
# $ elixir -r chain.ex -e "Chain.run(1_000)"
# elixir -r chain.ex -e "Chain.run(10_000)"
# $ elixir -r chain.ex -e "Chain.run(400_000)"
# 22:19:31.189 [error] Too many processes
# (SystemLimitError) a system limit has been reached
# $ elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(400_000)"
# $ elixir --erl "+P 1000000" -r chain.ex -e "Chain.run(1_000_000)"
# 
### Result
#
# OS X El Capitan Late 2013 Macbook Pro(2.8GHz Intel Corei7, 16GB RAM)
# Elixir 1.5.1
# 
# {3906, "Result is 10"}
# {3739, "Result is 100"}
# {8766, "Result is 1000"}
# {119035, "Result is 10000"}
# {3946317, "Result is 400000"}
# {9346716, "Result is 1000000"}
