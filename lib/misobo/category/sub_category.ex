defmodule Misobo.SubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:category_id, :name]
  @optional [:desc, :is_enabled]

  schema "sub_categories" do
    field :desc, :string
    field :name, :string
    field :category_id, :id
    field :is_enabled, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
