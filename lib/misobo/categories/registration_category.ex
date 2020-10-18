defmodule Misobo.Categories.RegistrationCategory do
  @moduledoc """
  This module contains the registration category schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Accounts.Registration
  alias Misobo.Categories.Category

  @already_exists "ALREADY_EXISTS"
  @required [:registration_id, :category_id]

  @primary_key false
  schema "registration_categories" do
    belongs_to :registration, Registration, primary_key: true
    belongs_to :category, Category, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(registration_category, attrs) do
    registration_category
    |> cast(attrs, @required)
    |> validate_required(@required)
    |> foreign_key_constraint(:registration_id)
    |> foreign_key_constraint(:category_id)
    |> unique_constraint([:registration, :category],
      name: :category_id_registration_id_unique_index,
      message: @already_exists
    )
  end

  def map_registration_category(registration, categories) do
    registration_categories_existing = registration.categories

    registration
    |> Misobo.Repo.preload(:categories)
    |> Ecto.Changeset.change()
    |> Ecto.Changeset.put_assoc(
      :categories,
      registration_categories_existing ++ [categories]
    )
    |> Misobo.Repo.update()
  end
end
