defmodule Misobo.Experts.ExpertCategoryMapping do
  @moduledoc """
  This module is related to expert-category-mappping
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Experts.Expert
  alias Misobo.Experts.ExpertCategory

  @already_exists "ALREADY_EXISTS"
  @required [:expert_category_id, :expert_id]

  @primary_key false
  schema "expert_category_mappings" do
    belongs_to :expert_category, ExpertCategory, primary_key: true
    belongs_to :expert, Expert, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(expert_category_mapping, attrs) do
    expert_category_mapping
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:expert_category_id)
    |> foreign_key_constraint(:expert_id)
    |> unique_constraint([:user, :project],
      name: :expert_category_id_expert_id_unique_index,
      message: @already_exists
    )
  end

  def map_author_book(expert, expert_categories) do
    expert_categories_existing = expert.expert_categories

    expert
    |> Misobo.Repo.preload(:expert_categories)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(
      :expert_categories,
      expert_categories_existing ++ [expert_categories]
    )
    |> Misobo.Repo.update()
  end
end
