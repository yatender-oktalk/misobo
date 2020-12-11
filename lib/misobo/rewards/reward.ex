defmodule Misobo.Rewards.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rewards" do
    field :company, :string
    field :company_logo, :string
    field :how_to_redeem, :string
    field :img, :string
    field :karma, :integer
    field :offer_details, :string
    field :people_unlocked, :integer, default: 0
    field :terms_and_conditions, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(reward, attrs) do
    reward
    |> cast(attrs, [
      :title,
      :company,
      :company_logo,
      :img,
      :karma,
      :people_unlocked,
      :offer_details,
      :how_to_redeem,
      :terms_and_conditions
    ])
    |> validate_required([
      :title,
      :company,
      :img,
      :karma,
      :people_unlocked,
      :offer_details,
      :how_to_redeem,
      :terms_and_conditions
    ])
  end
end
