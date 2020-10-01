defmodule Misobo.Astrology.Horoscorpe do
  use Ecto.Schema
  import Ecto.Changeset

  schema "horoscopes" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(horoscorpe, attrs) do
    horoscorpe
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
