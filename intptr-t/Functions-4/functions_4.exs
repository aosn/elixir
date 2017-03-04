prefix = fn str1 -> 
  fn str2 -> 
    "#{str1} #{str2}"
  end
end

#iex> mrs = prefix.("Mrs") 
#Function<6.52032458/1 in :erl_eval.expr/5>
#iex> mrs.("Smith")        
#"Mrs Smith"
#iex> prefix.("Elixir").("Rocks")
#"Elixir Rocks"
#iex> 
