defmodule Misobo.Experts.ExpertCategory do
  @moduledoc """
  This module is having the expert categories
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "expert_categories" do
    field :enabled_at, :naive_datetime
    field :is_enabled, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(expert_category, attrs) do
    expert_category
    |> cast(attrs, [:name, :is_enabled, :enabled_at])
    |> validate_required([:name, :is_enabled, :enabled_at])
  end
end
