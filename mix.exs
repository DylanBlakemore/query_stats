defmodule QueryStats.MixProject do
  use Mix.Project

  def project do
    [
      app: :query_stats,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      preferred_cli_env: ["test.all": :test],
      dialyzer: [plt_add_apps: [:mix]],
      test_coverage: [
        summary: [threshold: 95]
      ]
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
