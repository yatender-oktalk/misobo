defmodule Misobo.Repo.Migrations.CreateRewardCodes do
  use Ecto.Migration

  def change do
    create table(:reward_codes) do
      add :code, :string
      add :valid_from, :naive_datetime
      add :valid_upto, :naive_datetime
      add :is_active, :boolean, default: false, null: false
      add :redeemed_on, :naive_datetime
      add :reward_id, references(:rewards, on_delete: :nothing)

      timestamps()
    end

    create index(:reward_codes, [:reward_id])
  end
end
