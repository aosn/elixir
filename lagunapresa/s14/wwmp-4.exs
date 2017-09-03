defmodule Wwmp4 do
  import :timer, only: [ sleep: 1 ]

  def run() do
    p = spawn_link __MODULE__, :send_and_raise, []
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

# iex(1)> Wwmp4.run()
#
# 22:39:41.269 [error] Process #PID<0.126.0> raised an exception
# ** (RuntimeError) boom
#     wwmp-4.exs:18: Wwmp4.send_and_raise/0
# ** (EXIT from #PID<0.118.0>) an exception was raised:
#     ** (RuntimeError) boom
#         wwmp-4.exs:18: Wwmp4.send_and_raise/0
