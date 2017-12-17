defmodule Ticker do

  @interval 10000
  @name     :Ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator([pid|clients])
    after
      @interval ->
        IO.puts "tick"
        case clients do
          [client|rest] ->
            send client, { :tick, rest }
            generator(clients)
          _ ->
            generator(clients)
        end
    end
  end
end

defmodule Client do
  @wait 2000
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver do
    receive do
      { :tick, clients } ->
        IO.puts "tock in client"
        case clients do
          [client | rest] ->
            :timer.send_after(@wait, client, { :tick, rest })
          _ ->
        end
        receiver()
    end
  end
end
