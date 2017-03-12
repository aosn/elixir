a = [1, 2, 3]           #=> [1, 2, 3]
a = 4                   #=> 4
4 = a                   #=> 4
[a, b] = [1, 2, 3]      # ** (MatchError) no match of right hand side value: [1, 2, 3]
a = [ [ 1, 2, 3 ] ]     #=> [[1, 2, 3]], a is [[1, 2, 3]]
[a] = [ [ 1, 2, 3 ] ]   #=> [[1, 2, 3]], a is [1, 2, 3]
[[a]] = [ [ 1, 2, 3 ] ] # ** (MatchError) no match of right hand side value: [[1, 2, 3]]
