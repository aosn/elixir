defmodule MacroAndCodeEvaluation3 do
  defmacro explain(expression) do
    do_expr   = Keyword.get(expression, :do, nil)
    translate_expr(:explain, do_expr)
  end

  @operator [:+, :-, :*, :/]

  defp translate_expr(:explain, {operator, _meta, [left, right]})
      when operator in @operator
      and is_number(left)
      and is_number(right) do
    make_text(operator, left, right)
  end

  defp translate_expr(:explain, {operator, _meta, [left, right]})
      when operator in @operator
      and is_number(left) do
    preferred = translate_expr(:explain, right)
    "#{preferred}, then #{op_text(operator)} #{left}"
  end

  defp translate_expr(:explain, {operator, _meta, [left, right]})
      when operator in @operator
      and is_number(right) do    
    preferred = translate_expr(:explain, left)
    "#{preferred}, then #{op_text(operator)} #{right}"
  end

  defp translate_expr(:explain, {operator, _meta, [left, right]})
      when operator in @operator do
    preferred_l = translate_expr(:explain, left)
    preferred_r = translate_expr(:explain, right)
    "#{preferred_l} #{preferred_r}, then #{op_text(operator)}"
  end

  def op_text(op) do
    case op do
      :+ -> "add"
      :- -> "substract"
      :* -> "multiply"
      :/ -> "divide"
      _ -> raise "Unknown operator #{op}"
    end
  end

  defp make_text(op, left, right) do
    "#{op_text(op)} #{left} and #{right}"
  end
end
  
defmodule Test do 
  import MacroAndCodeEvaluation3 

  IO.puts "#=> #{inspect explain do: 2 + 3 * 4}"
  IO.puts "#=> #{inspect explain do: (2 + 3) * 4}"
  IO.puts "#=> #{inspect explain do: (2 + 3) * (4 + 5)}"
  IO.puts "#=> #{inspect explain do: (2 + 3) * (4 + 5) * 6 + 7}"  
end

#=> "multiply 3 and 4, then add 2"
#=> "add 2 and 3, then multiply 4"
#=> "add 2 and 3 add 4 and 5, then multiply"
#=> "add 2 and 3 add 4 and 5, then multiply, then multiply 6, then add 7"