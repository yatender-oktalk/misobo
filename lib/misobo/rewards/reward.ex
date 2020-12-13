defmodule Misobo.Rewards.Reward do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           [
             only: [
               :company,
               :company_logo,
               :how_to_redeem,
               :img,
               :karma,
               :offer_details,
               :people_unlocked,
               :terms_and_conditions,
               :title,
               :is_active
             ]
           ]}
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
    field :is_active, :boolean, default: true

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
