defmodule WorkingWithMultipleProcesses5 do
  import :timer, only: [ sleep: 1 ]

  def send_message_and_exit(pid) do
    send pid, "Hello, world!"
    exit(:boom)
  end

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

  def run_with_exit do
    Process.flag(:trap_exit, true)
    spawn_monitor(__MODULE__, :send_message_and_exit, [self()])
    sleep 500
    receive_loop()
  end

  def run_with_raise do
    Process.flag(:trap_exit, true)
    spawn_monitor(__MODULE__, :send_message_and_raise, [self()])
    sleep 500
    receive_loop()
  end
end

WorkingWithMultipleProcesses5.run_with_exit()
WorkingWithMultipleProcesses5.run_with_raise()

# MESSAGE RECEIVED: "Hello, world!"
# MESSAGE RECEIVED: {:DOWN, #Reference<0.0.3.7>, :process, #PID<0.77.0>, :boom}
# Nothing happened

# MESSAGE RECEIVED: "Hello, world!"
# MESSAGE RECEIVED: {:DOWN, #Reference<0.0.3.24>, :process, #PID<0.78.0>, {%RuntimeError{message: "oops"}, [{WorkingWithMultipleProcesses5, :send_message_and_raise, 1, [file: 'working_with_multiple_processes_5.ex', line: 11]}]}}
# Nothing happened
