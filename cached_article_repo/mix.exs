defmodule CachedArticleRepo.MixProject do
  use Mix.Project

  def project do
    [
      app: :cached_article_repo,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:html_article, path: "../html_article"},
      {:article,  path: "../article"},
      {:fs_article_reader, path: "../fs_article_reader"}
    ]
  end
end
