defmodule WWMP5 do
  import :timer, only: [ sleep: 1 ]

  def normal_exit(sender_pid) do
    send sender_pid, {self(), "message from normal"}
    exit :boom
  end

  def exception_exit(sender_pid) do
    send sender_pid, {self(), "message from exception"}
    raise "die"
  end

  def run() do
    Process.flag(:trap_exit, true)

    _pid = spawn_monitor(WWMP5, :normal_exit, [self()])
    sleep 500
    receive do
      msg -> IO.puts "MESSAGE RECEIVED #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happend normal_exit"
    end

    IO.inspect "------------------------"

    _pid = spawn_monitor(WWMP5, :exception_exit, [self()])
    sleep 500
    receive do
      msg -> IO.puts "MESSAGE RECEIVED #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happend exception_exit"
    end
  end
end

# iex(1)> WWMP5.run()
# MESSAGE RECEIVED {#PID<0.90.0>, "message from normal"}
# "------------------------"
# 
# 22:48:38.390 [error] Process #PID<0.91.0> raised an exception
# ** (RuntimeError) die
#     WorkingWithMultipleProcesses-5.exs:11: WWMP5.exception_exit/1
# MESSAGE RECEIVED {:DOWN, #Reference<0.3706763593.2041315331.188707>, :process, #PID<0.90.0>, :boom}
# :ok