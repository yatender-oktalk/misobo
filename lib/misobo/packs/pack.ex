defmodule Misobo.Packs.Pack do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           [
             only: [
               :id,
               :is_enabled,
               :amount,
               :karma_coins,
               :tag
             ]
           ]}
  schema "packs" do
    field :amount, :decimal
    field :is_enabled, :boolean, default: true
    field :karma_coins, :integer
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(pack, attrs) do
    pack
    |> cast(attrs, [:amount, :is_enabled, :karma_coins, :tag])
    |> validate_required([:amount, :karma_coins])
  end
end
