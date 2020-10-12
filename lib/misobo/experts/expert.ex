defmodule Misobo.Experts.Expert do
  @moduledoc """
  This module is having the expert related schema
  """
  use Ecto.Schema
  import Ecto.Changeset

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
    :total_consultations
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
    timestamps()
  end

  @doc false
  def changeset(expert, attrs) do
    expert
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
