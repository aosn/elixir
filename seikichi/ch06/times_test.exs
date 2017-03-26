ExUnit.start

defmodule TimesTest do
  use ExUnit.Case, async: true

  test "double" do
    assert Times.double(42) == 84
  end

  test "triple" do
    assert Times.triple(42) == 126
  end

  test "quadruple" do
    assert Times.quadruple(42) == 168
  end
end
