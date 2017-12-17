defmodule TurnTicker do
  @interval 2000
  @name :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def generator(clients, notified_clients) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
        generator([pid | clients], notified_clients)
    after @interval ->
        IO.puts "tick"
        case clients do
          [client] ->
            send client, {:tick}
            generator(Enum.reverse([client | notified_clients]), [])
          [client | rest] ->
            send client, {:tick}
            generator(rest, [client | notified_clients])
          [] ->
            generator(clients, notified_clients)
        end
    end
  end
end
