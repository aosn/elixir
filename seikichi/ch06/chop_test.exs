ExUnit.start

defmodule ChopTest do
  use ExUnit.Case, async: true

  test "helper(273, 500, 1..1000)" do
    assert Chop.helper(273, 500, 1..1000) === [500, 250, 375, 312, 281, 265, 273]
  end
end
