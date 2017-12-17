defmodule Stack.Server do
  use GenServer

  #####
  # public API

  def start_link(start_stack \\ []) do
    GenServer.start_link(__MODULE__, start_stack, name: __MODULE__)
  end

  def pop() do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  #####
  # GenServer implementation

  def handle_call(:pop, _from, current_stack) do
    [head | tail] = current_stack
    {:reply, head, tail}
  end

  def handle_cast({:push, item}, current_stack) do
    if length(current_stack) > 2 do
      #raise "Boooom"
      System.halt 255
    end
    {:noreply, [item | current_stack]}
  end

  def terminate(reason, state) do
    IO.puts "reason=#{inspect reason}"
    IO.puts "state=#{inspect state}"
  end
end

##########
## 実行結果 例外発生
##########
# iex(1)> Stack.Server.start_link
# {:ok, #PID<0.123.0>}
# iex(2)> Stack.Server.pop
# reason={{:badmatch, []}, [{Stack.Server, :handle_call, 3, [file: 'lib/stack.ex', line: 23]}, {:gen_server, :try_handle_call, 4, [file: 'gen_server.erl', line: 636]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 665]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}
# state=[]
# ** (EXIT from #PID<0.121.0>) evaluator process exited with reason: an exception was raised:
#     ** (MatchError) no match of right hand side value: []
#         (stack) lib/stack.ex:23: Stack.Server.handle_call/3
#         (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#         (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#         (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# 
# (iexの再起動は省略)

##########
## 実行結果 例外発生
##########
# iex(1)> Stack.Server.start_link
# {:ok, #PID<0.123.0>}
# iex(2)> Stack.Server.push 1
# :ok
# iex(3)> Stack.Server.push 2
# :ok
# iex(4)> Stack.Server.push 3
# :ok
# iex(5)> Stack.Server.push 4
# :ok
# reason={%RuntimeError{message: "Boooom"}, [{Stack.Server, :handle_cast, 2, [file: 'lib/stack.ex', line: 29]}, {:gen_server, :try_dispatch, 4, [file: 'gen_server.erl', line: 616]}, {:gen_server, :handle_msg, 6, [file: 'gen_server.erl', line: 686]}, {:proc_lib, :init_p_do_apply, 3, [file: 'proc_lib.erl', line: 247]}]}
# state=[3, 2, 1]
# ** (EXIT from #PID<0.121.0>) evaluator process exited with reason: an exception was raised:
#     ** (RuntimeError) Boooom
#         (stack) lib/stack.ex:29: Stack.Server.handle_cast/2
#         (stdlib) gen_server.erl:616: :gen_server.try_dispatch/4
#         (stdlib) gen_server.erl:686: :gen_server.handle_msg/6
#         (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
#         
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(6)> 
# 22:26:52.370 [error] GenServer Stack.Server terminating
# ** (RuntimeError) Boooom
#     (stack) lib/stack.ex:29: Stack.Server.handle_cast/2
#     (stdlib) gen_server.erl:616: :gen_server.try_dispatch/4
#     (stdlib) gen_server.erl:686: :gen_server.handle_msg/6
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Last message: {:"$gen_cast", {:push, 4}}
# State: [3, 2, 1]
# 

##########
## 実行結果 System.haltで終了したケース
##########
# iex(1)> Stack.Server.start_link
# {:ok, #PID<0.123.0>}
# iex(2)> Stack.Server.push 1
# :ok
# iex(3)> Stack.Server.push 2
# :ok
# iex(4)> Stack.Server.push 3
# :ok
# iex(5)> Stack.Server.push 4
# $ echo $?
# 255
# 