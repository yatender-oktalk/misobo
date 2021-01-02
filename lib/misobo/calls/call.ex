defmodule Misobo.Calls.Call do
  use Ecto.Schema
  import Ecto.Changeset

  schema "calls" do
    field :account_sid, :string
    field :answered_by, :string
    field :caller_name, :string
    field :date_created, :naive_datetime
    field :date_updated, :naive_datetime
    field :direction, :string
    field :duration, :integer
    field :end_time, :naive_datetime
    field :forwared_from, :string
    field :from, :string
    field :parent_call_sid, :string
    field :phone_number_sid, :string
    field :price, :decimal
    field :recording_url, :string
    field :sid, :string
    field :start_time, :naive_datetime
    field :status, :string
    field :to, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(call, attrs) do
    call
    |> cast(attrs, [
      :sid,
      :parent_call_sid,
      :date_created,
      :date_updated,
      :account_sid,
      :to,
      :from,
      :phone_number_sid,
      :status,
      :start_time,
      :end_time,
      :duration,
      :price,
      :direction,
      :answered_by,
      :forwared_from,
      :caller_name,
      :url,
      :recording_url
    ])
    |> validate_required([:sid])
  end
end
