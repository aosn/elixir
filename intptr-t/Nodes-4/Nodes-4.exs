defmodule RingTicker do

  @interval 2000    # 2 seconds
  @name     :ticker

  def start() do
    server_pid = spawn(__MODULE__, :generator, [])
    :global.register_name(@name, server_pid)
  end

  def register() do
    client_pid = spawn(__MODULE__, :receiver, [])
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(next_pid \\ self()) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        send pid, {:join, next_pid}
        receiver(pid)
    after
      @interval ->
        IO.puts "tick #{inspect next_pid}"
        send next_pid, {:tick}
        receiver(next_pid)
    end
  end

  def receiver(next_pid \\ self()) do
    receive do
      {:join, new_pid} -> 
        IO.puts "new #{inspect self()} -> #{inspect new_pid}"
        generator(new_pid)
      {:tick} -> 
        IO.puts "tock #{inspect self()} -> #{inspect next_pid}"
        generator(next_pid)
    end
  end  
end
