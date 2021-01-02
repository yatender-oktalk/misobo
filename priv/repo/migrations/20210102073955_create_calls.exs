defmodule Misobo.Repo.Migrations.CreateCalls do
  use Ecto.Migration

  def change do
    create table(:calls) do
      add :sid, :string
      add :parent_call_sid, :string
      add :date_created, :naive_datetime
      add :date_updated, :naive_datetime
      add :account_sid, :string
      add :to, :string
      add :from, :string
      add :phone_number_sid, :string
      add :status, :string
      add :start_time, :naive_datetime
      add :end_time, :naive_datetime
      add :duration, :integer
      add :price, :decimal
      add :direction, :string
      add :answered_by, :string
      add :forwared_from, :string
      add :caller_name, :string
      add :url, :string
      add :recording_url, :string

      timestamps()
    end

  end
end
