# Sequence

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sequence` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sequence, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sequence](https://hexdocs.pm/sequence).

## Result Example

### "current_number and delta" values are inherited

```elixir
$ iex -S mix
iex(1)> Sequence.Server.next_number
"The next number is 456"
iex(2)> Sequence.Server.next_number
"The next number is 457"
iex(3)> Sequence.Server.increment_number 10
:ok
iex(4)> Sequence.Server.next_number        
"The next number is 468"
iex(5)> Sequence.Server.next_number
"The next number is 478"
iex(6)> Sequence.Server.abort      
:ok
iex(7)> 
00:31:43.917 [error] GenServer Sequence.Server terminating
** (RuntimeError) Boooom
    (sequence) lib/sequence/server.ex:60: Sequence.Server.handle_cast/2
    (stdlib) gen_server.erl:616: :gen_server.try_dispatch/4
    (stdlib) gen_server.erl:686: :gen_server.handle_msg/6
    (stdlib) proc_lib.erl:247: :proc_lib.init_p_do_apply/3
Last message: {:"$gen_cast", :abort}
State: %Sequence.Server.State{current_number: 488, delta: 10, stash_pid: #PID<0.197.0>}
iex(7)> Sequence.Server.next_number
"The next number is 488"

```