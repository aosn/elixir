defmodule TupleOps do
  def ok!({:ok, data}), do: data
  def ok!(x), do: raise "Not OK: #{Kernel.inspect(x)}"
end

# iex(2)> TupleOps.ok!({:ok, "aaa"})
# "aaa"
#
# iex(3)> TupleOps.ok!({:ng, "aaa"})
# ** (RuntimeError) Not OK: {:ng, "aaa"}
#     ControlFlow-3.exs:3: TupleOps.ok!/1
