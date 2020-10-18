defmodule Misobo.Categories.RegistrationSubCategory do
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Accounts.Registration
  alias Misobo.Categories.SubCategory

  @already_exists "ALREADY_EXISTS"
  @required [:registration_id, :sub_category_id]

  @primary_key false
  schema "registration_sub_categories" do
    belongs_to :registration, Registration, primary_key: true
    belongs_to :sub_category, SubCategory, primary_key: true

    timestamps()
  end

  def changeset(registration_category, attrs) do
    registration_category
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:registration_id)
    |> foreign_key_constraint(:sub_category_id)
    |> unique_constraint([:registration, :sub_category],
      name: :sub_category_id_registration_id_unique_index,
      message: @already_exists
    )
  end
end
