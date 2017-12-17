IO.puts IO.ANSI.format(["hello, ", :inverse, :bright, "world!"], true)

# iex(1)> IO.ANSI.format(["hello, ", :inverse, :bright, "world!"], true)
# [[[[[[], "hello, "] | "\e[7m"] | "\e[1m"], "world!"] | "\e[0m"]