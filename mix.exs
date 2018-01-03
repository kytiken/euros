defmodule Euros.Mixfile do
  use Mix.Project

  def project do
    [
      app: :euros,
      version: "0.2.1",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),

      # Docs
      name: "Euros",
      source_url: "https://github.com/kytiken/euros",
      homepage_url: "https://github.com/kytiken/euros",
      docs: [main: "Euros.Core", # The main page in the docs
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

  defp description do
    "Euros web-spider framework"
  end

  defp package() do
    [
      # This option is only needed when you don't want to use the OTP application name
      name: "euros",
      # These are the default files included in the package
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["kytiken"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kytiken/euros"}
    ]
  end
end
