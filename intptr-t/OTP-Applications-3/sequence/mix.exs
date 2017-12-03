defmodule Sequence.Mixfile do
  use Mix.Project

  def project do
    [
      app: :sequence,
      version: "0.0.4",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Sequence.Application, []},
      env: [initial_number: 456, initial_delta: 1],
      registerd: [Sequence.Server]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exrm, "~> 1.0.0-rc7"}
    ]
  end
end
