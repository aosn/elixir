
defmodule WorkingWithMultipleProcesses1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    exit( :boom )
  end

  def run do
    res = spawn_monitor( WorkingWithMultipleProcesses1, :sad_function, [] )
    sleep 500
    IO.puts inspect res

    receive do
      msg ->
	IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
	IO.puts "Nothing happened as far as I am concerned"
    end
  end
end



