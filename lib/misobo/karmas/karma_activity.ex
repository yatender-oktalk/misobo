defmodule Misobo.Karmas.KarmaActivity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "karma_activities" do
    field :event_type, :string
    field :karma_points, :integer
    field :user_id, :id
    field :music_id, :id

    timestamps()
  end

  @doc false
  def changeset(karma_activity, attrs) do
    karma_activity
    |> cast(attrs, [:karma_points, :event_type, :user_id, :music_id])
    |> validate_required([:karma_points, :event_type, :user_id, :music_id])
  end
end
