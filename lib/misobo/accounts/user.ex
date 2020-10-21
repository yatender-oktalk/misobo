defmodule Misobo.Accounts.User do
  @moduledoc """
  Account related functions
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Misobo.Accounts.LoginStreak
  alias Misobo.Accounts.Registration

  @required [:phone, :otp_valid_time, :registration_id]
  @optional [:name, :is_enabled, :otp, :karma_points, :dob, :daily_reminder]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :dob,
               :phone,
               :is_enabled,
               :karma_points,
               :name,
               :horoscope_id,
               :registration_id,
               :daily_reminder
             ]
           ]}
  schema "users" do
    field :dob, :naive_datetime
    field :otp_valid_time, :naive_datetime
    field :is_enabled, :boolean, default: false
    field :karma_points, :integer, default: 0
    field :name, :string
    field :otp, :integer
    field :phone, :string
    field :horoscope_id, :id
    field :daily_reminder, :integer

    belongs_to :registration, Registration
    has_one(:login_streak, LoginStreak, on_delete: :delete_all)
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> unique_constraint(:phone, name: :users_phone_index)
  end
end
