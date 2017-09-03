defmodule WWMP2 do
  def echo() do
    receive do
      {sender, token} -> send sender,{self(), token}
    end
  end
end

pid1 = spawn(WWMP2, :echo, [])
pid2 = spawn(WWMP2, :echo, [])

send pid1, {self(), "Fred"}
send pid2, {self(), "Betty"}

receive do
  {^pid2, token} -> IO.puts "Betty Echo #{token}"
after 500 ->
  "Betty not echo..."
end

receive do
  {^pid1, token} -> IO.puts "Fred Echo #{token}"
after 500 ->
  "Fred not echo..."
end

# プロセスから帰って来る返事の順序は論理的に決定的であるか？
# => Maybe No.
#
# 実際は？
# => No.
#
# どうすれば順序を決定的にできるだろうか？
# => 受け取る順番で、決定的であるように振る舞うことができる
#