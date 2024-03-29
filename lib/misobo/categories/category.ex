defmodule Misobo.Categories.Category do
  @moduledoc """
  This module has schema of category
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Misobo.Accounts.Registration
  alias Misobo.Categories.RegistrationCategory
  alias Misobo.Categories.SubCategory

  @required [:name]
  @optional [:desc, :is_enabled]

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :name,
               :desc,
               :sub_category
             ]
           ]}
  schema "categories" do
    field :desc, :string
    field :name, :string
    field :is_enabled, :boolean, default: true

    has_many(:sub_category, SubCategory)

    many_to_many(
      :registrations,
      Registration,
      join_through: RegistrationCategory,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
  end
end
