defmodule QueryStats.MixProject do
  use Mix.Project

  def project do
    [
      app: :query_stats,
      version: "0.1.1",
      description: "Track Ecto queries in your test suite",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: ["test.all": :test],
      dialyzer: [plt_add_apps: [:mix]],
      package: package(),
      source_url: "https://github.com/DylanBlakemore/query_stats",
      homepage_url: "https://github.com/DylanBlakemore/query_stats",
      test_coverage: [
        summary: [threshold: 95]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE* CHANGELOG*),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/DylanBlakemore/query_stats"}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:telemetry_metrics, "~> 0.6"}
    ]
  end

  defp aliases do
    [
      "test.lint": [
        "credo --strict",
        "format --check-formatted --dry-run",
        "dialyzer"
      ],
      "test.all": [
        "test --cover --export-coverage default",
        "test.coverage",
        "test.lint"
      ]
    ]
  end
end
