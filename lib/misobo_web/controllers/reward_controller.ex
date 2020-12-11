defmodule MisoboWeb.RewardController do
  @moduledoc """
  This module defines the Reward releated stuff
  """
  use MisoboWeb, :controller
  alias Misobo.Accounts.User
  alias Misobo.Rewards
  alias Misobo.Rewards.{Reward}

  def index(conn, _params) do
    response(conn, 200, %{data: Rewards.list_rewards(), msg: :ok})
  end

  def show(conn, %{"id" => id}) do
    case Rewards.get_reward(id) do
      nil -> response(conn, 200, %{data: %{}, msg: "Reward not found"})
      reward -> response(conn, 200, %{data: reward, msg: "ok"})
    end
  end

  def redeem(%{assigns: %{user: %User{id: user_id}}} = conn, %{"reward_id" => reward_id}) do
    with %Reward{is_active: true} <- Rewards.get_reward(reward_id) do
      response(conn, 400, %{data: "Reward ok", msg: :ok})
    else
      %Reward{is_active: false} ->
        response(conn, 400, %{data: "Reward inactive", msg: :error})
    end

    # get the reward
    # check if the reward is active
  end

  # Private functions

  defp response(conn, status, data) do
    conn
    |> put_status(status)
    |> json(data)
  end
end
