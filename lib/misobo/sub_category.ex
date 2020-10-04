defmodule Misobo.SubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:category_id, :name]
  @optional [:desc]

  schema "sub_categories" do
    field :desc, :string
    field :name, :string
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
