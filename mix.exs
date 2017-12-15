defmodule Euros.Mixfile do
  use Mix.Project

  def project do
    [
      app: :euros,
      version: "0.0.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps(),

      # Docs
      name: "Euros",
      source_url: "https://github.com/kytiken/euros",
      homepage_url: "https://github.com/kytiken/euros",
      docs: [main: "Euros", # The main page in the docs
            extras: ["README.md"]]
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
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:httpoison, "~> 0.13"},
      {:floki, "~> 0.19.0"}
    ]
  end
end
