defmodule Misobo.Experts.ExpertCategoryMapping do
  @moduledoc """
  This module is related to expert-category-mappping
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Experts.ExpertCategory
  alias Misobo.Experts.Expert

  @already_exists "ALREADY_EXISTS"
  @required [:category_id, :expert_id]

  @primary_key false
  schema "expert_category_mappings" do
    belongs_to :category, ExpertCategory, primary_key: true
    belongs_to :expert, Expert, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(expert_category_mapping, attrs) do
    expert_category_mapping
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:category_id)
    |> foreign_key_constraint(:expert_id)
    |> unique_constraint([:user, :project],
      name: :category_id_expert_id_unique_index,
      message: @already_exists
    )
  end
end
