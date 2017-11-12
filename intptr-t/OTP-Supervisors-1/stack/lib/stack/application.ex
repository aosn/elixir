defmodule Stack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    # List all child processes to be supervised
    children = [
      worker(Stack.Server, [[5, "cat", 9]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stack.Supervisor]
    {:ok, _pid} = Supervisor.start_link(children, opts)
  end
end

## 実行結果
# iex(1)> Stack.Server.pop
# 5
# iex(2)> Stack.Server.pop
# "cat"
# iex(3)> Stack.Server.pop
# 9
# iex(4)> Stack.Server.pop
# ** (exit) exited in: GenServer.call(Stack.Server, :pop, 5000)
#     ** (EXIT) an exception was raised:
#         ** (MatchError) no match of right hand side value: []
#             (stack) lib/stack/server.ex:23: Stack.Server.handle_call/3
#             (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#             (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#             (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
#     (elixir) lib/gen_server.ex:774: GenServer.call/3
# iex(4)> 
# 21:43:00.063 [error] GenServer Stack.Server terminating
# ** (MatchError) no match of right hand side value: []
#     (stack) lib/stack/server.ex:23: Stack.Server.handle_call/3
#     (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
#     (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
#     (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
# Last message (from #PID<0.114.0>): :pop
# State: []
# Client #PID<0.114.0> is alive
#     (stdlib) gen.erl:169: :gen.do_call/4
#     (elixir) lib/gen_server.ex:771: GenServer.call/3
#     (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
#     (elixir) src/elixir.erl:239: :elixir.eval_forms/4
#     (iex) lib/iex/evaluator.ex:231: IEx.Evaluator.handle_eval/5
#     (iex) lib/iex/evaluator.ex:212: IEx.Evaluator.do_eval/3
#     (iex) lib/iex/evaluator.ex:190: IEx.Evaluator.eval/3
#     (iex) lib/iex/evaluator.ex:89: IEx.Evaluator.loop/1
# 
# iex(4)> Stack.Server.pop
# 5
# iex(5)> Stack.Server.pop
# "cat"
# iex(6)> Stack.Server.pop
# 9
