defmodule Times do
  defmacro times_n(n) do
    func_name = "times_#{n}"
    quote do
      def unquote(String.to_atom(func_name))(rhs) do
        unquote(n) * rhs
      end
    end
  end
end

# 使い方の例
defmodule Test do
  require Times
  Times.times_n(3)
  Times.times_n(4)
end

IO.puts Test.times_3(4)
IO.puts Test.times_4(5)

# $ iex MacrosAndCodeEvaluation-2.exs 
# 12
# 20
