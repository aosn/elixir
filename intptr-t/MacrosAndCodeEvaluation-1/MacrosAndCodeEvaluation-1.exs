defmodule MyUnless do
  defmacro myunless(condition, clauses) do 
    do_clause   = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)
    quote do
      if unquote(condition) do 
        unquote(else_clause)
      else
        unquote(do_clause)
      end
    end
  end
end

# 使い方の例
defmodule Test do
  require MyUnless
  MyUnless.myunless 1 == 2 do
    IO.puts "1 != 2"
  else
    IO.puts "1 == 2"
  end
end


# $ iex MacrosAndCodeEvaluation-1.exs
# 1 != 2
