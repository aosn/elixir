defmodule SummationTest do
    use ExUnit.Case

    test "Sum 10" do
        assert Summation.of(0) == 0
        assert Summation.of(10) == 55
    end

end