defmodule Misobo.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:name]
  @optional [:desc, :is_enabled]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :name,
               :desc
             ]
           ]}
  schema "categories" do
    field :desc, :string
    field :name, :string
    field :is_enabled, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
