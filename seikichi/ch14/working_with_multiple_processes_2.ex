defmodule WorkingWithMultipleProcesses2 do
  def echo do
    receive do
      {sender, msg} -> send sender, {:ok, msg}
      echo()
    end
  end

  def run do
    pid1 = spawn(WorkingWithMultipleProcesses2, :echo, [])
    pid2 = spawn(WorkingWithMultipleProcesses2, :echo, [])

    send pid1, {self(), "fred"}
    send pid2, {self(), "betty"}

    receive do
      {:ok, message} -> IO.puts message
    end
    receive do
      {:ok, message} -> IO.puts message
    end
  end
end
