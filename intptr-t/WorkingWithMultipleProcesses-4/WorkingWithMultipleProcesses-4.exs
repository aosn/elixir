defmodule WWMP4 do
  import :timer, only: [ sleep: 1 ]
  def exception_exit(sender_pid) do
    send sender_pid, {self(), "message from child"}
    raise "die"
  end

  def run() do
    Process.flag(:trap_exit, true)
    _pid = spawn_link(WWMP4, :exception_exit, [self()])
    sleep 500
    receive do
      msg -> IO.puts "MESSAGE RECEIVED #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happend exception_exit"
    end
  end
end

# iex(1)> WWMP4.run()

# 22:47:20.944 [error] Process #PID<0.90.0> raised an exception
# ** (RuntimeError) die
#     WorkingWithMultipleProcesses-4.exs:5: WWMP4.exception_exit/1
# MESSAGE RECEIVED {#PID<0.90.0>, "message from child"}
# :ok