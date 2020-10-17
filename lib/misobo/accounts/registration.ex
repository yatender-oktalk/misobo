defmodule Misobo.Accounts.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  schema "registrations" do
    field :device_id, :string

    timestamps()
  end

  @doc false
  def changeset(registration, attrs) do
    registration
    |> cast(attrs, [:device_id])
    |> validate_required([:device_id])
  end
end
