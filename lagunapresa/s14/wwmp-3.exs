defmodule Wwmp3 do
  import :timer, only: [ sleep: 1 ]

  def run() do
    p = spawn_link __MODULE__, :send_and_die, []
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

# iex(2)> Wwmp3.run()
# ** (EXIT from #PID<0.100.0>) :boom
