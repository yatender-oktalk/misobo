defmodule Misobo.Experts.ExpertCategory do
  @moduledoc """
  This module is having the expert categories
  """
  use Ecto.Schema
  import Ecto.Changeset
  @required [:name, :enabled_at]
  @optional [:is_enabled]

  alias Misobo.Experts.Expert

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :name
             ]
           ]}
  schema "expert_categories" do
    field :enabled_at, :naive_datetime
    field :is_enabled, :boolean, default: true
    field :name, :string

    many_to_many(
      :experts,
      Expert,
      join_through: "expert_category_mappings",
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(expert_category, attrs) do
    expert_category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@optional)
  end
end
