defmodule Misobo.Repo.Migrations.SmsSentToFlow do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :otp_sent_phone, :string
    end
  end
end
