defmodule Misobo.Accounts.LoginStreak do
  @moduledoc """
  This module takes care of the login streak
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required [:"1", :"2", :"3", :"4", :"5", :"6", :"7", :user_id]
  @optional [:streak_days]

  @derive {Jason.Encoder,
           [
             only: [
               :"1",
               :"2",
               :"3",
               :"4",
               :"5",
               :"6",
               :"7",
               :user_id
             ]
           ]}
  schema "login_streaks" do
    field :"1", :boolean, default: false
    field :"2", :boolean, default: false
    field :"3", :boolean, default: false
    field :"4", :boolean, default: false
    field :"5", :boolean, default: false
    field :"6", :boolean, default: false
    field :"7", :boolean, default: false
    field :streak_days, :integer, default: 0
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(login_streak, attrs) do
    login_streak
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
    |> assoc_constraint(:user_id, name: :login_streak_user_ibfk_1)
  end
end
