defmodule Wwmp5_1 do
  import :timer, only: [ sleep: 1 ]

  def run() do
    p = spawn_monitor __MODULE__, :send_and_die, []
    send p, self()
    sleep(500)
    receive do
      any -> IO.inspect any
    after 1000 ->
      IO.puts "end"
    end
  end
  def send_and_die do
    receive do
      sender ->
        send sender, "message"
        exit(:boom)
    end
  end
end

# iex(3)> Wwmp5_1.run()
# ** (ArgumentError) argument error
#     :erlang.send({#PID<0.141.0>, #Reference<0.303469917.3918266372.190567>}, #PID<0.127.0>)
#     wwmp-5-1.exs:6: Wwmp5_1.run/0
