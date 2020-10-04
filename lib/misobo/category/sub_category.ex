defmodule Misobo.SubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Category

  @required [:category_id, :name]
  @optional [:desc, :is_enabled]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :name
             ]
           ]}
  schema "sub_categories" do
    field :desc, :string
    field :name, :string

    belongs_to :category, Category
    field :is_enabled, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(sub_category, attrs) do
    sub_category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> assoc_constraint(:category, name: :sub_categories_category_id_fkey)
  end
end
