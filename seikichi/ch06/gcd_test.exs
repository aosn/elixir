ExUnit.start

defmodule GcdTest do
  use ExUnit.Case, async: true

  test "gcd 1 1" do
    assert Gcd.gcd(1, 1) == 1
  end

  test "gcd 6 4" do
    assert Gcd.gcd(6, 4) == 2
  end
end
