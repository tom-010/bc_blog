defmodule E2e.MixProject do
  use Mix.Project

  def project do
    [
      app: :e2e,
      version: "0.1.0",
      elixir: "~> 1.8",
      deps: [{:httpoison, "~> 1.5"}]
    ]
  end

  def application do
    []
  end

end
