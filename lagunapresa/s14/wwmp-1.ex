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

    send last, 0

    receive do
      final_answer when is_integer(final_answer) ->
        "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    IO.puts inspect :timer.tc(Chain, :create_processes, [n])
  end
end

# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(10)"
# {7565, "Result is 10"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(100)"
# {8378, "Result is 100"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(1000)"
# {20458, "Result is 1000"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(10000)"
# {156181, "Result is 10000"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(100000)"
# {1231405, "Result is 100000"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir -r wwmp-1.ex -e "Chain.run(1000000)"
#
# 22:20:41.864 [error] Too many processes
#
#
# ** (SystemLimitError) a system limit has been reached
#     :erlang.spawn(Chain, :counter, [#PID<0.74.8>])
#     wwmp-1.ex:12: anonymous fn/2 in Chain.create_processes/1
#     (elixir) lib/enum.ex:1785: Enum.reduce_range_inc/4
#     wwmp-1.ex:10: Chain.create_processes/1
#     (stdlib) timer.erl:197: :timer.tc/3
#     wwmp-1.ex:24: Chain.run/1
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
#
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir --erl "+P 1000000" -r wwmp-1.ex -e "Chain.run(400000)"
# {5919389, "Result is 400000"}
# LagunaPresa:~/repo/aosn/elixir/lagunapresa/s14 (master $%<>) $ elixir --erl "+P 1000000" -r wwmp-1.ex -e "Chain.run(1000000)"
# {15294684, "Result is 1000000"}
