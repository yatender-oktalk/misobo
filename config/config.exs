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
  secret_key_base: "DnUYDIBX616rMHUGPLAxgQFYBsWmsTSa16d1qZCiLuTnr0ML1YWO1ixsz4Gqqm0M",
  render_errors: [view: MisoboWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Misobo.PubSub,
  live_view: [signing_salt: "RVxKLfu3"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :misobo, :communication,
  sms: Misobo.Communication.SMSProvider.TextLocal,
  call: Misobo.Communication.CallProvider.Exotel

config :misobo, MisoboWeb.Authentication, namespace: "user_auth"

config :misobo, Misobo.Env,
  signup_karma: 501,
  music_listen_activity: "MUSIC_LISTEN_COMPLETE"

config :misobo, Misobo.Communication.SMSProvider.TextLocal,
  api_key: System.get_env("TEXT_LOCAL_API_KEY")

config :misobo, :env,
  timezone: System.get_env("TIMEZONE", "Asia/Kolkata"),
  start_time: System.get_env("START_TIME", "36000"),
  end_time: System.get_env("END_TIME", "64800"),
  slot_duration: System.get_env("SLOT_DURATION", "1800")

config :misobo, Misobo.Scheduler,
  jobs: [
    # Every Monday 00:00 AM
    {"0 0 * * 1", {Misobo.Accounts, :clear_login_streak, []}},
    {"*/1 * * * *", {Misobo.Services.Notifications.DailyNotificationWorker, :send_reminder, []}},
    {"*/1 * * * *", {Misobo.Services.Notifications.BookingNotificationWorker, :send_reminder, []}}
    {"*/1 * * * *", {Misobo.Services.Notifications.CallConnectionWorker, :connect_call, []}}
  ]

config :pigeon, :fcm,
  fcm_default: %{
    key:
      "AAAAJbbFAoY:APA91bFimkkK75Y9T6XBZW9KAvoK8MXieMyTVDj_J3NatMzvF989HURclv4pYbmcuAl13Hy1H9Mnzo7p06kGEJRfbxKVjmroEbJAGGkwazInU8m-2mz0iLFLPwpnmSa1kZAz6ey4gf9K"
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
