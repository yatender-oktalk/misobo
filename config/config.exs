# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :misobo,
  ecto_repos: [Misobo.Repo]

# Configures the endpoint
config :misobo, MisoboWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bxKdlRIUPLMlaMXQEtNn9uObohZEyJuqMnanhGwpNAjpYj8xNmPb6Zx4JVdkjDQG",
  render_errors: [view: MisoboWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Misobo.PubSub,
  live_view: [signing_salt: "RVxKLfu3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :misobo, :communication, sms: Misobo.Communication.SMSProvider.TextLocal

config :misobo, MisoboWeb.Authentication, namespace: "user_auth"

config :misobo, Misobo.Communication.SMSProvider.TextLocal,
  api_key: System.get_env("TEXT_LOCAL_API_KEY")

config :misobo, :env,
  timezone: System.get_env("TIMEZONE", "Asia/Kolkata"),
  start_time: System.get_env("START_TIME", "36000"),
  end_time: System.get_env("END_TIME", "64800"),
  slot_duration: System.get_env("SLOT_DURATION", "1800")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
