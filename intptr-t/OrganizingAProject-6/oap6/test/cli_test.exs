defmodule CliTest do
  use ExUnit.Case
  doctest Oap6

  import Oap6.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",      "anything"]) == :help
    assert parse_args(["--help",  "anything"]) == :help
  end

  test "one list values returned if one given" do
    assert parse_args(["KDTO"]) == { "KDTO" }
  end

  test "two is defaulted if one values given" do
    assert parse_args(["KDTO", "dummy"]) == { "KDTO" }
  end

  test "three is defaulted if one values given" do
    assert parse_args(["KDTO", "dummy1", "dummy2"]) == { "KDTO" }
  end
end