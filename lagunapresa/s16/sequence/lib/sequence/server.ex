# OPT-Servers-1 implemented
# OPT-Servers-2 implemented
# OPT-Servers-4 implemented

defmodule Sequence.Server do
  use GenServer

  ### APIs ###

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def push(value) do
    GenServer.cast(__MODULE__, {:push, value})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  ### Implementations ###

  def handle_cast({:push, value}, current_stack) do
    { :noreply, [value|current_stack] }
  end

  def handle_call(:pop, _from, [head|rest]) do
    { :reply, head, rest }
  end

  def terminate(reason, []) do
    System.halt(0)
  end
end

# iex(1)> {:ok,pid}=GenServer.start_link(Sequence.Server, [])
# {:ok, #PID<0.123.0>}
# iex(2)> GenServer.call(pid, {:push, 1})
# []
# iex(3)> GenServer.call(pid, {:push, 2})
# [1]
# iex(4)> GenServer.call(pid, {:push, 3})
# [2, 1]
# iex(5)> GenServer.call(pid, :pop)
# 3
# iex(6)> GenServer.call(pid, :pop)
# 2
# iex(7)> GenServer.call(pid, :pop)
# 1
# iex(8)> GenServer.call(pid, :pop)
# ** (EXIT from #PID<0.121.0>) evaluator process exited with reason: an exception was raised:


# OPT-Servers-3 tried

# iex(1)> GenServer.start_link(Sequence.Server, [1,2,3], name: :seq)
# {:ok, #PID<0.157.0>}
# iex(1)> GenServer.cast(:seq, {:push, 1})
# :ok


# OPT-Servers-4 tried

# iex(1)> Sequence.Server.start_link([1])
# {:ok, #PID<0.123.0>}
# iex(2)> Sequence.Server.push(2)
# :ok
# iex(3)> Sequence.Server.push(3)
# :ok
# iex(4)> Sequence.Server.pop
# 3
# iex(5)> Sequence.Server.pop
# 2
# iex(6)> Sequence.Server.pop
# 1


# OPT-Servers-5 tried before terminate-callback implemented

# iex(8)> Sequence.Server.pop
# 22:06:59.760 [error] GenServer Sequence.Server terminating
# ** (FunctionClauseError) no function clause matching in Sequence.Server.handle_call/3
#     (sequence) lib/sequence/server.ex:27: Sequence.Server.handle_call(:pop, {#PID<0.121.0>, #Reference<0.938239410.4283170819.80605>}, [])
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

# OPT-Servers-5 IO.puts

# iex(1)> Sequence.Server.start_link([])
# {:ok, #PID<0.123.0>}
# iex(2)> Sequence.Server.pop
# ** (EXIT from #PID<0.121.0>) evaluator process exited with reason: an exception was raised:
#     ** (ArgumentError) argument error
#         (stdlib) :io.put_chars(:standard_io, :unicode, [[reason: {:function_clause, [{Sequence.Server, :handle_call, [:pop, {#PID<0.121.0>, #Reference<0.4220810695.1062993923.261771>}, []], [file: 'lib/sequence/server.ex', line: 28]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 636]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 665]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}, state: []], 10])
#         (stdlib) gen_server.erl:648: :gen_server.try_terminate/3
#         (stdlib) gen_server.erl:833: :gen_server.terminate/10
#         (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3

# OPT-Servers-5 System.halt(0)

# iex(1)> Sequence.Server.start_link([])
# {:ok, #PID<0.123.0>}
# iex(2)> Sequence.Server.pop
