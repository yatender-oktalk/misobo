defmodule Misobo.Experts.ExpertCategoryMapping do
  @moduledoc """
  This module is related to expert-category-mappping
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Experts.ExpertCategory
  alias Misobo.Experts.Expert

  @required [:category_id, :expert_id]

  schema "expert_category_mappings" do
    belongs_to :category, ExpertCategory
    belongs_to :expert, Expert

    timestamps()
  end

  @doc false
  def changeset(expert_category_mapping, attrs) do
    expert_category_mapping
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> assoc_constraint(:expert, name: :expert_category_mapping_expert_id_fkey)
    |> assoc_constraint(:category, name: :expert_category_mapping_category_fkey)
  end
end
