defmodule Tracer do
  def dump_args(args) do 
    args |> Enum.map(&inspect/1) |> Enum.join(", ")
  end

  def dump_defn(name, args) do 
    "#{name}(#{dump_args(args)})"
  end

  ## `defmacro def`で何が渡されるかを確認するための定義
  #defmacro def(definition, content) do
  #  IO.inspect definition
  #  IO.inspect content
  #  quote do
  #    Kernel.def(unquote(definition)) do
  #      :dummy
  #    end
  #  end
  #end

  defmacro def({:when,_,[definition={name,_,args}, when_cond]}, do: content) do
    quote do
      Kernel.def(unquote(definition) when unquote(when_cond)) do
        call_text = "#{Tracer.dump_defn(unquote(name), unquote(args))}"
        IO.puts IO.ANSI.format([:inverse, "==>call:    #{call_text}"])
        result = unquote(content)
        IO.ANSI.green_background()
        IO.puts IO.ANSI.format([:red, :green_background, "<== result: #{result}"])
        result
      end
    end
  end

  defmacro def(definition={name,_,args}, do: content) do 
    quote do
      Kernel.def(unquote(definition)) do
        call_text = "#{Tracer.dump_defn(unquote(name), unquote(args))}"
        IO.puts IO.ANSI.format([:inverse, "==>call:    #{call_text}"])
        result = unquote(content)
        IO.ANSI.green_background()
        IO.puts IO.ANSI.format([:red, :green_background, "<== result: #{result}"])
        result
      end
    end
  end

  defmacro __using__(_opts) do
    quote do
      import Kernel, except: [def: 2]
      import unquote(__MODULE__), only: [def: 2]
    end
  end  
end

defmodule Test do
  import Kernel, except: [def: 2]
  import Tracer, only:   [def: 2]

  def puts_sum_three(a,b,c),  do: IO.inspect(a+b+c)
  def add_list(list),         do: Enum.reduce(list, 0, &(&1+&2))

  def puts(n)
    when is_number(n),        do: IO.puts "n is a number."
  def puts(n),                do: IO.puts "n is not a number."
end

#Test.puts_sum_three(1, 2, 3)
#Test.add_list([5, 6, 7, 8])

Test.puts(1)
Test.puts('ab')

# Q. うまくいかない理由を見つけよう
# A. whenが無い場合`defmacro def`の第１引数は
#       `{関数(名のアトム), [行番号情報], 引数のメタ情報}`のタプルである
#    whenがある場合`defmacro def`の第１引数は
#       `{when, [whenの行番号情報], [{関数(名のアトム), [行番号情報], 引数のメタ情報}, {whenの条件}]}`
#    となり、期待するマッチをしなくなっているためうまくいかない
#    (関数 <-> when, 引数のメタ情報 <-> 関数名などのリスト・when条件 と不一致になっている)
#
# --- whenがある場合の引数情報
# {:when, [line: 53],
# [{:puts, [line: 52], [{:n, [line: 52], nil}]},
#  {:is_number, [line: 53], [{:n, [line: 53], nil}]}]}
#
# [do: {{:., [line: 53], [{:__aliases__, [counter: 0, line: 53], [:IO]}, :puts]},
#  [line: 53], ["n is a number."]}]
# ---- whenが無い場合の引数情報
# {:puts, [line: 54], [{:n, [line: 54], nil}]}
#
# [do: {{:., [line: 54], [{:__aliases__, [counter: 0, line: 54], [:IO]}, :puts]},
#  [line: 54], ["n is not a number."]}]

# when対応版の`defmacro def`を定義した後の実行結果
# ==>call:    puts(1)
# n is a number.
# <== result: ok
# ==>call:    puts('ab')
# n is not a number.
# <== result: ok