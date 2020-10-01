defmodule Misobo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :dob, :naive_datetime
    field :is_enabled, :boolean, default: false
    field :karma_points, :integer
    field :name, :string
    field :otp, :integer
    field :phone, :string
    field :horoscope_id, :id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :phone, :is_enabled, :otp, :karma_points, :dob])
    |> validate_required([:name, :phone, :is_enabled, :otp, :karma_points, :dob])
  end
end
