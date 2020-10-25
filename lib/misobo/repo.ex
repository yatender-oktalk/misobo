defmodule Misobo.Repo do
  use Ecto.Repo, otp_app: :misobo, adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 20
end
