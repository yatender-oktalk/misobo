defmodule Misobo.Experts.Booking do
  @moduledoc """
  This module is the booking module related schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Accounts.User
  alias Misobo.Experts.Expert

  @required [
    :expert_id,
    :user_id,
    :start_time,
    :end_time,
    :start_time_unix,
    :end_time_unix,
    :karma
  ]
  @optional [:is_rated]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :karma,
               :expert_id,
               :user_id,
               :start_time,
               :end_time,
               :expert
             ]
           ]}
  schema "bookings" do
    field :end_time, :naive_datetime
    field :start_time, :naive_datetime
    field :end_time_unix, :integer
    field :start_time_unix, :integer
    field :karma, :integer
    field :is_rated, :boolean

    belongs_to :expert, Expert
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
