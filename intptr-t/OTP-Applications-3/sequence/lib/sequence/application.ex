defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    {:ok, _pid} = Sequence.Supervisor.start_link([
      initial_number: Application.get_env(:sequence, :initial_number),
      initial_delta:  Application.get_env(:sequence, :initial_delta)
    ])
  end
end
