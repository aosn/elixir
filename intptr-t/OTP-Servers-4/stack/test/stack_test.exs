defmodule Stack.ServerTest do
  use ExUnit.Case
  doctest Stack.Server

  test "pop" do
    expacted = [5, "cat", 9]

    {:ok, pid} = GenServer.start_link(Stack.Server, [5, "cat", 9])    
    actual = [
      GenServer.call(pid, :pop),
      GenServer.call(pid, :pop),
      GenServer.call(pid, :pop)
    ]
    
    assert expacted == actual
  end

  test "push" do
    expacted = [5, "cat", 9]

    {:ok, pid} = GenServer.start_link(Stack.Server, [])
    GenServer.cast(pid, {:push, 9})
    GenServer.cast(pid, {:push, "cat"})
    GenServer.cast(pid, {:push, 5})    
    actual = [
      GenServer.call(pid, :pop),
      GenServer.call(pid, :pop),
      GenServer.call(pid, :pop)
    ]
    
    assert expacted == actual
    
  end
end
