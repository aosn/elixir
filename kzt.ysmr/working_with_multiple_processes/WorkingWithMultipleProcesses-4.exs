
defmodule WorkingWithMultipleProcesses4 do
  import :timer, only: [ sleep: 1 ]

  def sad_function( parent ) do
    raise "I'm going to die..."
  end

  def receiver do
    receive do
      msg ->
	IO.puts "MESSAGE RECEIVED: #{inspect msg}"
	receiver()
    after 1000 ->
	IO.puts "Nothing happened as far as I am concerned"
    end
  end
  
  def run do
    Process.flag( :trap_exit, true )
    spawn_link( __MODULE__, :sad_function, [self()] )
    sleep 500
    receiver()
  end
end
