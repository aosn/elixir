defmodule Stack.Server do
  use GenServer

  def handle_call(:pop, _from, current_stack) do
    [head | tail] = current_stack
    {:reply, head, tail}
  end

  def handle_cast({:push, item}, current_stack) do
    {:noreply, [item | current_stack]}
  end
end

# iex(1)> {:ok, pid} = GenServer.start_link(Stack.Server, [])
# {:ok, #PID<0.124.0>}
# iex(2)> GenServer.cast(pid, {:push, 5})
# :ok
# iex(3)> GenServer.cast(pid, {:push, "cat"})
# :ok
# iex(4)> GenServer.cast(pid, {:push, 9})
# :ok
# iex(5)> GenServer.call(pid, :pop)
# 9
# iex(6)> GenServer.call(pid, :pop)
# "cat"
# iex(7)> GenServer.call(pid, :pop)
# 5
# iex(8)> GenServer.call(pid, :pop)
# ** (EXIT from #PID<0.121.0>) evaluator process exited with reason: an exception was raised:
#     ** (MatchError) no match of right hand side value: []
#         (stack) lib/stack.ex:5: Stack.Server.handle_call/3
#         (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#         (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#         (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# 
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> 
# 21:12:24.414 [error] GenServer #PID<0.124.0> terminating
# ** (MatchError) no match of right hand side value: []
#     (stack) lib/stack.ex:5: Stack.Server.handle_call/3
#     (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#     (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Last message (from #PID<0.121.0>): :pop
# State: []
# Client #PID<0.121.0> is alive
#     (stdlib) gen.erl:169: :gen.do_call/4
#     (elixir) lib/gen_server.ex:771: GenServer.call/3
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
#     (elixir) src/elixir.erl:239: :elixir.eval_forms/4
#     (iex) lib/iex/evaluator.ex:231: IEx.Evaluator.handle_eval/5
#     (iex) lib/iex/evaluator.ex:212: IEx.Evaluator.do_eval/3
#     (iex) lib/iex/evaluator.ex:190: IEx.Evaluator.eval/3
#     (iex) lib/iex/evaluator.ex:89: IEx.Evaluator.loop/1
