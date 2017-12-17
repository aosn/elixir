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
    {:noreply, [item | current_stack]}
  end
end
