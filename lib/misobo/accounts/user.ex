defmodule Misobo.Accounts.User do
  @moduledoc """
  Account related functions
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Misobo.Accounts.LoginStreak
  alias Misobo.Accounts.Registration

  @required [:phone]
  @optional [
    :registration_id,
    :otp_valid_time,
    :name,
    :is_enabled,
    :otp,
    :karma_points,
    :dob,
    :daily_reminder,
    :img,
    :weight,
    :bmi,
    :height,
    :login_streak_days,
    :bmi_checked_at,
    :is_body_pack_unlocked,
    :is_mind_pack_unlocked
  ]

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
               :daily_reminder,
               :img,
               :weight,
               :bmi,
               :height,
               :login_streak_days,
               :login_streak,
               :bmi_checked_at,
               :is_body_pack_unlocked,
               :is_mind_pack_unlocked
             ]
           ]}
  schema "users" do
    field :dob, :naive_datetime
    field :otp_valid_time, :naive_datetime
    field :is_enabled, :boolean, default: false
    field :is_body_pack_unlocked, :boolean, default: false
    field :is_mind_pack_unlocked, :boolean, default: false
    field :karma_points, :integer, default: 0
    field :name, :string
    field :otp, :integer
    field :phone, :string
    field :horoscope_id, :integer
    field :daily_reminder, :integer
    field :img, :string
    field :weight, :float
    field :bmi, :float
    field :height, :float
    field :login_streak_days, :integer, default: 0
    field :bmi_checked_at, :naive_datetime, default: nil

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
    |> validate_number(:karma_points, greater_than: 0)
  end
end
