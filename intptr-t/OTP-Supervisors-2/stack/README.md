# Stack

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `stack` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stack, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stack](https://hexdocs.pm/stack).

## Result Example

```elixir
iex(1)> Stack.Server.pop
5
iex(2)> Stack.Server.abort
:ok
iex(3)> 
23:36:34.875 [error] GenServer Stack.Server terminating
** (RuntimeError) Boooom
    (stack) lib/stack/server.ex:44: Stack.Server.handle_cast/2
    (stdlib) gen_server.erl:616: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:686: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", :abort}
State: {["cat", 9], #PID<0.113.0>}
iex(3)> Stack.Server.pop  
"cat"
iex(4)> Stack.Server.abort
:ok
iex(5)> 
23:36:45.149 [error] GenServer Stack.Server terminating
** (RuntimeError) Boooom
    (stack) lib/stack/server.ex:44: Stack.Server.handle_cast/2
    (stdlib) gen_server.erl:616: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:686: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", :abort}
State: {'\t', #PID<0.113.0>}
iex(5)> Stack.Server.pop  
9
iex(6)> Stack.Server.pop
** (exit) exited in: GenServer.call(Stack.Server, :pop, 5000)
    ** (EXIT) an exception was raised:
        ** (MatchError) no match of right hand side value: []
            (stack) lib/stack/server.ex:35: Stack.Server.handle_call/3
            (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
            (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
            (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
    (elixir) lib/gen_server.ex:774: GenServer.call/3
iex(6)> 
23:36:56.301 [error] GenServer Stack.Server terminating
** (MatchError) no match of right hand side value: []
    (stack) lib/stack/server.ex:35: Stack.Server.handle_call/3
    (stdlib) gen_server.erl:636: :gen_server.try_handle_call/4
    (stdlib) gen_server.erl:665: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message (from #PID<0.116.0>): :pop
State: {[], #PID<0.113.0>}
Client #PID<0.116.0> is alive
    (stdlib) gen.erl:169: :gen.do_call/4
    (elixir) lib/gen_server.ex:771: GenServer.call/3
    (stdlib) erl_eval.erl:670: :erl_eval.do_apply/6
    (elixir) src/elixir.erl:239: :elixir.eval_forms/4
    (iex) lib/iex/evaluator.ex:231: IEx.Evaluator.handle_eval/5
    (iex) lib/iex/evaluator.ex:212: IEx.Evaluator.do_eval/3
    (iex) lib/iex/evaluator.ex:190: IEx.Evaluator.eval/3
    (iex) lib/iex/evaluator.ex:89: IEx.Evaluator.loop/1

 
iex(7)> 
```