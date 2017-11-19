defmodule Stack.ServerTest do
  use ExUnit.Case
  use GenServer
  doctest Stack.Server

  test "pop" do
    expacted = [5, "cat", 9]

    Stack.Application.start(nil, [expacted])
    actual = [
      Stack.Server.pop(),
      Stack.Server.pop(),
      Stack.Server.pop()
    ]
    
    assert expacted == actual
  end

  test "push" do
    expacted = [5, "cat", 9]

    Stack.Application.start(nil, [expacted])

    Stack.Server.push 9
    Stack.Server.push "cat"
    Stack.Server.push 5
    actual = [
      Stack.Server.pop(),
      Stack.Server.pop(),
      Stack.Server.pop()
    ]
    assert expacted == actual
  end
end
