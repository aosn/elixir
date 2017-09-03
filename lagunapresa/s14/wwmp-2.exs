# 実際には繰り返し試してみたが順序が変わることはなかった。ただし論理的には決定的でないと思う。
# 決定的にするには以下のように、fredのプロセスからトークンを返された後でbettyのプロセスにトークンを送る。

defmodule Human do
  def self_introduction() do
    receive do
      { sender, name } ->
        send sender, name
    end
  end
end

defmodule Client do
  def call([]) do end
  def call([name | rest]) do
    send spawn(Human, :self_introduction, []), { self(), name }
    receive do
      name ->
        IO.puts name
        call(rest)
    end
  end
end

Client.call(["fred", "betty"])

# fred
# betty
