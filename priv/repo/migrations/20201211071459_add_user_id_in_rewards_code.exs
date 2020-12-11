defmodule Misobo.Repo.Migrations.AddUserIdInRewardsCode do
  use Ecto.Migration

  def change do
    alter table(:reward_codes) do
      add :user_id, references(:users, on_delete: :nothing)
    end

    drop table(:user_rewards)
  end
end
