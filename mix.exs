defmodule Misobo.MixProject do
  use Mix.Project

  def project do
    [
      app: :misobo,
      version: "0.7.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      dialyzer: dialyzer(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Misobo.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # testing only

      # dev only
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:credo, "~> 1.1", only: [:dev, :test], runtime: false},

      # all
      {:phoenix, "~> 1.5.5"},
      {:phoenix_ecto, "~> 4.1"},
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_live_dashboard, "~> 0.2"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:plug_cowboy, "~> 2.0"},
      {:typed_struct, "~>0.2"},
      {:tesla, "~> 1.3.0"},
      {:timex, "~> 3.5"},
      {:scrivener_ecto, "~> 2.0"},
      {:hackney, "~> 1.10"}
      # dev internal
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "ecto.seed": ["run priv/repo/seeds.exs"],
      test: ["ecto.drop", "ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp dialyzer() do
    [
      plt_add_deps: :app_tree,
      plt_add_apps: [:ex_unit],
      plt_ignore_apps: [],
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
    ]
  end
end
