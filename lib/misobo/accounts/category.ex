defmodule Misobo.Account.Category do
  use Ecto.Schema
  import Ecto.Changeset

  @required [:name]
  @optional [:desc]

  schema "categories" do
    field :desc, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
