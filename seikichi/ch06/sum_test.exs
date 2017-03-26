ExUnit.start

defmodule SumTest do
  use ExUnit.Case, async: true

  test "sum 0" do
    assert Sum.sum(0) == 0
  end

  test "sum 1" do
    assert Sum.sum(1) == 1
  end

  test "sum 5" do
    assert Sum.sum(5) == 15
  end
end
