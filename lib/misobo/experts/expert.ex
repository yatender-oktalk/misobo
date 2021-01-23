defmodule Misobo.Experts.Expert do
  @moduledoc """
  This module is having the expert related schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Experts.Expert
  alias Misobo.Experts.ExpertCategory
  alias Misobo.Experts.ExpertCategoryMapping

  @required [:language, :name]
  @optional [
    :about,
    :category_order,
    :consult_karma,
    :experience,
    :img,
    :is_enabled,
    :order,
    :rating,
    :total_consultations,
    :qualification,
    :expertise,
    :location,
    :tags,
    :email,
    :phone,
    :unavailable_days
  ]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :name,
               :about,
               :consult_karma,
               :experience,
               :img,
               :is_enabled,
               :language,
               :rating,
               :qualification,
               :expertise,
               :location,
               :tags,
               :email,
               :total_consultations
             ]
           ]}
  schema "experts" do
    field :about, :string
    field :category_order, :integer
    field :consult_karma, :integer
    field :experience, :integer
    field :img, :string
    field :is_enabled, :boolean, default: true
    field :language, :string
    field :name, :string
    field :order, :integer
    field :rating, :decimal
    field :total_consultations, :integer, default: 0
    field :phone, :string
    field :qualification, :string
    field :expertise, :string
    field :location, :string
    field :tags, :string
    field :email, :string
    field :unavailable_days, :string

    many_to_many(
      :expert_categories,
      ExpertCategory,
      join_through: ExpertCategoryMapping,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(expert, attrs) do
    expert
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end

  def changeset_update_expert_categories(%Expert{} = expert, expert_categories) do
    expert
    |> cast(%{}, @required ++ @optional)
    |> validate_required(@required)
    # associate categories to the expert
    |> put_assoc(:expert_categories, expert_categories)
  end
end
