
defmodule OK do
  def ok!( { :ok, data } ), do: data
  def ok!( anything ), do: raise "Possibly an error: " <> Kernel.inspect( anything )
end
