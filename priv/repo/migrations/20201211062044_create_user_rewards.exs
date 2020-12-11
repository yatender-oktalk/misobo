defmodule Misobo.Repo.Migrations.CreateUserRewards do
  use Ecto.Migration

  def change do
    create table(:user_rewards) do
      add :reward_code, :string
      add :redeemed_at, :naive_datetime
      add :expire_at, :naive_datetime
      add :user_id, references(:users, on_delete: :nothing)
      add :reward_id, references(:rewards, on_delete: :nothing)

      timestamps()
    end

    create index(:user_rewards, [:user_id])
    create index(:user_rewards, [:reward_id])
  end
end
