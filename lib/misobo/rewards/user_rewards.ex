defmodule Misobo.Rewards.UserRewards do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_rewards" do
    field :expire_at, :naive_datetime
    field :redeemed_at, :naive_datetime
    field :reward_code, :string
    field :user_id, :id
    field :reward_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_rewards, attrs) do
    user_rewards
    |> cast(attrs, [:reward_code, :redeemed_at, :expire_at, :user_id, :reward_id])
    |> validate_required([:reward_code, :expire_at, :user_id, :reward_id])
  end
end
