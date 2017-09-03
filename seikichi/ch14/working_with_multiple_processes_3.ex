defmodule WorkingWithMultipleProcesses3 do
  import :timer, only: [ sleep: 1 ]

  def send_message_and_exit(pid) do
    send pid, "Hello, world!"
    exit(:boom)
  end

  def receive_loop do
    receive do
      msg -> IO.puts "MESSAGE RECEIVED: #{inspect(msg)}"
      receive_loop()
    after 1000 ->
      IO.puts "Nothing happened"
    end
  end

  def run do
    Process.flag(:trap_exit, true)
    spawn_link(__MODULE__, :send_message_and_exit, [self()])
    sleep 500
    receive_loop()
  end
end

WorkingWithMultipleProcesses3.run()

# ## output
# ```
# MESSAGE RECEIVED: "Hello, world!"
# MESSAGE RECEIVED: {:EXIT, #PID<0.77.0>, :boom}
# Nothing happened
# ```
