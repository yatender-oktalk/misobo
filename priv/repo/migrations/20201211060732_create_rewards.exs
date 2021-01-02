defmodule Misobo.Repo.Migrations.CreateRewards do
  use Ecto.Migration

  def change do
    create table(:rewards) do
      add :title, :string
      add :company, :string
      add :company_logo, :string
      add :img, :string
      add :karma, :integer
      add :people_unlocked, :integer
      add :offer_details, :text
      add :how_to_redeem, :text
      add :terms_and_conditions, :text

      timestamps()
    end
  end
end
