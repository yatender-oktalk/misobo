# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

config :misobo, Misobo.Repo,
  username: System.get_env("USERNAME"),
  password: System.get_env("PASSWORD"),
  database: System.get_env("DATABASE_URL"),
  hostname: System.get_env("HOST"),
  port: System.get_env("PG_PORT"),
  ssl: System.get_env("SSLMODE"),
  pool_size: System.get_env("DATABASE_URL")

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :misobo, MisoboWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
