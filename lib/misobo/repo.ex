defmodule Misobo.Repo do
  use Ecto.Repo,
    otp_app: :misobo,
    adapter: Ecto.Adapters.Postgres
end
