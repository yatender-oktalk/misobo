defmodule Misobo.Repo.Migrations.AddIsRatedInBookings do
  use Ecto.Migration

  def change do
    alter table(:bookings) do
      add :is_rated, :boolean
    end
  end
end
