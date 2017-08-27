defmodule Wwmp5_2 do
  import :timer, only: [ sleep: 1 ]

  def run() do
    p = spawn_monitor __MODULE__, :send_and_raise, []
    send p, self()
    sleep(500)
    receive do
      any -> IO.inspect any
    after 1000 ->
      IO.puts "end"
    end
  end
  def send_and_raise do
    receive do
      sender ->
        send sender, "message"
        raise "boom"
    end
  end
end

# iex(4)> Wwmp5_2.run()
# ** (ArgumentError) argument error
#     :erlang.send({#PID<0.149.0>, #Reference<0.303469917.3918266372.191913>}, #PID<0.127.0>)
#     wwmp-5-2.exs:6: Wwmp5_2.run/0
