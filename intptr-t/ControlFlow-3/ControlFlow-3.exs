defmodule ErrorWrapper do
  def ok!({:ok, data}),     do: data
  def ok!({err, message}),  do: raise "Fail. #{err} -- #{message}"
end

# iex(1)> c("ControlFlow-3.exs")
# [ErrorWrapper]
#
# iex(2)> import ErrorWrapper
# ErrorWrapper
#
# iex(3)> file = ok! File.open("somefile")
# ** (RuntimeError) Fail. error -- enoent
#     ControlFlow-3.exs:3: ErrorWrapper.ok!/1
#
# iex(3)> file = ok! File.open("ControlFlow-3.exs")
# #PID<0.95.0>