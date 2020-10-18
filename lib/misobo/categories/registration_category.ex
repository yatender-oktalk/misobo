defmodule Misobo.Categories.RegistrationCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "registration_categories" do
    field :registration_id, :id
    field :category_id, :id

    timestamps()
  end

  @doc false
  def changeset(registration_category, attrs) do
    registration_category
    |> cast(attrs, [])
    |> validate_required([])
  end
end
