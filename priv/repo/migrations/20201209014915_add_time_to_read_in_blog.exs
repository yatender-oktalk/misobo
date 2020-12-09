defmodule Misobo.Repo.Migrations.AddTimeToReadInBlog do
  use Ecto.Migration

  def change do
    alter table(:blogs) do
      add :time_to_read, :string
    end
  end
end
