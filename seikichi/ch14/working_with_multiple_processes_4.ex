defmodule WorkingWithMultipleProcesses4 do
  import :timer, only: [ sleep: 1 ]

  def send_message_and_raise(pid) do
    send pid, "Hello, world!"
    raise "oops"
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
    spawn_link(__MODULE__, :send_message_and_raise, [self()])
    sleep 500
    receive_loop()
  end
end

WorkingWithMultipleProcesses4.run()

# ## output
# ```
# MESSAGE RECEIVED: "Hello, world!"
# MESSAGE RECEIVED: {:EXIT, #PID<0.77.0>, {%RuntimeError{message: "oops"}, [{WorkingWithMultipleProcesses4, :send_message_and_exit, 1, [file: 'working_with_multiple_processes_4.ex', line: 6]}]}}
# Nothing happened
# ```
