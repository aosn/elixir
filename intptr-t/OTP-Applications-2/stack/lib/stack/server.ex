defmodule Stack.Server do
  use GenServer

  #####
  # public API

  def start_link(stash_pid) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def pop() do
    GenServer.call __MODULE__, :pop
  end

  def push(item) do
    GenServer.cast __MODULE__, {:push, item}
  end

  #####
  # Testing function
  @doc """
    This function is for testing and is not normally used.
  """
  def abort() do
    GenServer.cast __MODULE__, :abort
  end

  #####
  # GenServer implementation

  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    {:ok, {current_stack, stash_pid}}
  end

  def handle_call(:pop, _from, {current_stack, stash_pid}) do
    [head | tail] = current_stack
    {:reply, head, {tail, stash_pid}}
  end

  def handle_cast({:push, item}, {current_stack, stash_pid}) do
    {:noreply, {[item | current_stack], stash_pid}}
  end

  def handle_cast(:abort, {_current_stack, _stash_pid}) do
    raise "Boooom"
  end

  def terminate(_reason, {current_stack, stash_pid}) do
    Stack.Stash.save_value stash_pid, current_stack
  end
end
