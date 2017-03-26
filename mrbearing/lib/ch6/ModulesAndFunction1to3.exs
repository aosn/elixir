defmodule Times do
    def double(n) , do: n * 2
    def triple(n) , do: n * 3
    def quadruple(n) , do: double n * 2
end


# D:\SourceCode\AOSN\elixir\mrbearing\ch6>iex ModulesAndFunction1to3.exs
# Eshell V8.0  (abort with ^G)
# Interactive Elixir (1.4.2) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> Times.double 2
# 4
# iex(2)> Times.triple 3
# 9
# iex(3)> Times.quadruple 5
# 20
# iex(4)>


# iex(5)> c "ModulesAndFunction1to3.exs"
# [Times]
# iex(6)> double 2
# ** (CompileError) iex:6: undefined function double/1

# iex(6)> Times.double 2
# 4
# iex(7)> Times.triple 3
# 9
# iex(9)> Times.quadruple 5
# 20