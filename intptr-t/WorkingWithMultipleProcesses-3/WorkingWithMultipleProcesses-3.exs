defmodule WWMP3 do
  import :timer, only: [ sleep: 1 ]
  def normal_exit(sender_pid) do
    send sender_pid, {self(), "message from child"}
    exit :boom    
  end

  def run() do
    Process.flag(:trap_exit, true)
    _pid = spawn_link(WWMP3, :normal_exit, [self()])
    sleep 500
    receive do
      msg -> IO.puts "MESSAGE RECEIVED #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing happend normal_exit"
    end
  end
end

# iex(1)> WWMP3.run()
# MESSAGE RECEIVED {#PID<0.90.0>, "message from child"}
# :ok
