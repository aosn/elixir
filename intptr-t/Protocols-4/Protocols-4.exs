defmodule Protocol4 do
  defstruct member1: 0, member2: "0"

  def inspect(%Protocol4{member1: m1, member2: m2}, _opts) do
    "%Protocol4{member1=#{m1}, member2=#{m2}}"
  end
end

defmodule Test do
  p4_1 = %Protocol4{member1: 123, member2: "456"}
  p4_2 = IO.inspect p4_1
  IO.inspect p4_2
  IO.inspect p4_1 == p4_2

  p4_3 = IO.inspect p4_1, structs: false
  IO.inspect p4_1 == p4_3

  p4_4 = %{__struct__: Protocol4, member1: 123, member2: "456"}
  IO.inspect p4_1 == p4_4
end

# %Protocol4{member1: 123, member2: "456"}
# %Protocol4{member1: 123, member2: "456"}
# true
# %{__struct__: Protocol4, member1: 123, member2: "456"}
# true
# true