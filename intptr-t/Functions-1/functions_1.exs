list_concat = fn lhs, rhs -> lhs ++ rhs end
list_concat.([:a, :b], [:c, :d]) #=> [:a, :b, :c, :d]

sum = fn a, b, c -> a + b + c end
sum.(1, 2, 3) #=> 6

pair_tuple_to_list = fn {lhs,rhs} -> [lhs, rhs] end
pair_tuple_to_list.( { 1234, 5678 } ) #=> [1234, 5678]