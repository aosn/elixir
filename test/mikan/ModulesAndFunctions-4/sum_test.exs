defmodule SumTest do
  use ExUnit.Case
  test "1 case" do
    assert Sum.sum(1) == 1
  end
  test "normal case" do
    assert Sum.sum(2) == 1 + 2
    assert Sum.sum(3) == 1 + 2 + 3
    assert Sum.sum(4) == 1 + 2 + 3 + 4
  end
end