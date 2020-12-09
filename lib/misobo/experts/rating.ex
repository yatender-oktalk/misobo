defmodule Misobo.Experts.Rating do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ratings" do
    field :rating, :integer
    field :booking_id, :id
    field :user_id, :id
    field :expert_id, :id

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:rating, :booking_id, :user_id, :expert_id])
    |> validate_required([:rating, :booking_id, :user_id, :expert_id])
  end
end
