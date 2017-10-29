# OPT-Servers-1 implemented
# OPT-Servers-2 implemented

defmodule Sequence.Server do
  use GenServer

  def handle_cast({:push, value}, current_stack) do
    { :noreply, [value|current_stack] }
  end

  def handle_call(:pop, _from, [head|rest]) do
    { :reply, head, rest }
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
