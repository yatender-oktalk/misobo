defmodule Misobo.Accounts.Registration do
  use Ecto.Schema
  import Ecto.Changeset

  alias Misobo.Accounts.Registration
  alias Misobo.Categories.Category
  alias Misobo.Categories.RegistrationCategory

  @required [:device_id]
  @optional []
  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :device_id,
               :categories
             ]
           ]}
  schema "registrations" do
    field :device_id, :string

    many_to_many(
      :categories,
      Category,
      join_through: RegistrationCategory,
      on_replace: :delete
    )

    timestamps()
  end

  @doc false
  def changeset(registration, attrs) do
    registration
    |> cast(attrs, [:device_id])
    |> validate_required([:device_id])
  end

  def changeset_update_registration_categories(%Registration{} = registration, categories) do
    registration
    |> cast(%{}, @required ++ @optional)
    |> validate_required(@required)
    # associate categories to the registration
    |> put_assoc(:categories, categories)
  end
end
