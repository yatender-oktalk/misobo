defmodule Misobo.Rewards.RewardCode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reward_codes" do
    field :code, :string
    field :is_active, :boolean, default: true
    field :redeemed_on, :naive_datetime
    field :valid_from, :naive_datetime
    field :valid_upto, :naive_datetime
    field :reward_id, :id

    timestamps()
  end

  @doc false
  def changeset(reward_code, attrs) do
    reward_code
    |> cast(attrs, [:code, :valid_from, :valid_upto, :is_active, :redeemed_on, :reward_id])
    |> validate_required([:code, :valid_from, :valid_upto, :is_active, :reward_id])
  end
end
