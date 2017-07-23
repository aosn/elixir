defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]

  test "1" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "2" do
    assert parse_args(["user", "project", "99"]) == { "user", "project", 99 }
  end

  test "3" do
    assert parse_args(["user", "project"]) == { "user", "project", 4 }
  end

end
