defmodule Ticker do

  @interval 2000    # 2 seconds
  @name     :ticker

  def start() do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients])
    after
        @interval ->
        case clients do 
          [] ->  # no clients
            generator(clients)

          [client | tail] ->
            IO.puts "tick #{inspect client}"
            send client, {:tick}
            generator(tail ++ [client])
        end
    end
  end
end

defmodule Client do
  
  def start() do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end
  def receiver() do
    receive do
      {:tick} -> 
        IO.puts "tock in client"
        receiver()
    end
  end
end

# ------------------------- 
# Server "one"
# -------------------------
# $ iex --sname one
# Erlang/OTP 20 [erts-9.1.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
# 
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# 
# iex(one@tomono-mbp13)1> c("ticker.ex")
# [Client, Ticker]
# iex(one@tomono-mbp13)2> Node.connect :"two@tomono-mbp13"
# true
# iex(one@tomono-mbp13)3> Node.connect :"three@tomono-mbp13"
# true
# iex(one@tomono-mbp13)4> Ticker.start
# :yes
# registering #PID<13289.119.0>
# registering #PID<13371.125.0>
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# tick #PID<13371.125.0>  
# tick #PID<13289.119.0>  
# iex(one@tomono-mbp13)5> 

# ------------------------- 
# Client "two"
# -------------------------
# $ iex --sname two
# Erlang/OTP 20 [erts-9.1.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
# 
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(two@tomono-mbp13)1> c("ticker.ex")
# [Client, Ticker]
# iex(two@tomono-mbp13)2> Client.start   
# {:register, #PID<0.119.0>}
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client

# ------------------------- 
# Client "three"
# -------------------------
# tomono-mbp13:Nodes-3 tomono$ iex --sname three
# Erlang/OTP 20 [erts-9.1.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]
# 
# Interactive Elixir (1.5.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(three@tomono-mbp13)1> c("ticker.ex")
# [Client, Ticker]
# iex(three@tomono-mbp13)2> Client.start
# {:register, #PID<0.125.0>}
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client
# tock in client