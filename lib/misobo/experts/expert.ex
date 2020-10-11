defmodule Misobo.Experts.Expert do
  @moduledoc """
  This module is having the expert related schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "experts" do
    field :about, :string
    field :category_order, :integer
    field :consult_karma, :integer
    field :experience, :integer
    field :img, :string
    field :is_enabled, :boolean, default: false
    field :language, :string
    field :name, :string
    field :order, :integer
    field :rating, :decimal
    field :total_consultations, :integer
    timestamps()
  end

  @doc false
  def changeset(expert, attrs) do
    expert
    |> cast(attrs, [
      :name,
      :language,
      :rating,
      :total_consultations,
      :experience,
      :img,
      :consult_karma,
      :about,
      :is_enabled,
      :category_order,
      :order
    ])
    |> validate_required([
      :name,
      :language,
      :rating,
      :total_consultations,
      :experience,
      :img,
      :consult_karma,
      :about,
      :is_enabled,
      :category_order,
      :order
    ])
  end
end
