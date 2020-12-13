defmodule Misobo.Accounts.UserLogins do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_logins" do
    field :login_date, :naive_datetime
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_logins, attrs) do
    user_logins
    |> cast(attrs, [:login_date, :user_id])
    |> validate_required([:login_date, :user_id])
  end
end
