defmodule Misobo.Repo.Migrations.ExpertsBookingNotification do
  use Ecto.Migration

  def change do
    alter table(:experts) do
      add :phone, :string
    end

    alter table(:bookings) do
      add :precall_expert_notification_sent, :boolean
      add :precall_customer_notification_sent, :boolean
      add :booking_expert_notification_sent, :boolean
      add :booking_customer_notification_sent, :boolean
    end
  end
end
