defmodule Misobo.Repo.Migrations.CreateLoginStreaks do
  use Ecto.Migration

  def change do
    create table(:login_streaks) do
      add :streak_days, :integer
      add :"1", :boolean, default: false, null: false
      add :"2", :boolean, default: false, null: false
      add :"3", :boolean, default: false, null: false
      add :"4", :boolean, default: false, null: false
      add :"5", :boolean, default: false, null: false
      add :"6", :boolean, default: false, null: false
      add :"7", :boolean, default: false, null: false
      add :user_id, references(:users, name: "login_streak_user_ibfk_1",on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:login_streaks, [:user_id])
  end
end
