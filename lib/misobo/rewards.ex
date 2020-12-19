defmodule Misobo.Rewards do
  @moduledoc """
  The Rewards context.
  """

  import Ecto.Query, warn: false
  alias Misobo.Repo

  alias Misobo.Rewards.Reward
  alias Misobo.Accounts.User

  @doc """
  Returns the list of rewards.

  ## Examples

      iex> list_rewards()
      [%Reward{}, ...]

  """
  def list_rewards do
    query =
      from u in Reward,
        where: u.is_active == true

    Repo.all(query)
  end

  @doc """
  Gets a single reward.

  Raises `Ecto.NoResultsError` if the Reward does not exist.

  ## Examples

      iex> get_reward!(123)
      %Reward{}

      iex> get_reward!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward!(id), do: Repo.get!(Reward, id)

  def get_reward(id), do: Repo.get(Reward, id)

  @doc """
  Creates a reward.

  ## Examples

      iex> create_reward(%{field: value})
      {:ok, %Reward{}}

      iex> create_reward(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward(attrs \\ %{}) do
    %Reward{}
    |> Reward.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward.

  ## Examples

      iex> update_reward(reward, %{field: new_value})
      {:ok, %Reward{}}

      iex> update_reward(reward, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward(%Reward{} = reward, attrs) do
    reward
    |> Reward.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward.

  ## Examples

      iex> delete_reward(reward)
      {:ok, %Reward{}}

      iex> delete_reward(reward)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward(%Reward{} = reward) do
    Repo.delete(reward)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward changes.

  ## Examples

      iex> change_reward(reward)
      %Ecto.Changeset{data: %Reward{}}

  """
  def change_reward(%Reward{} = reward, attrs \\ %{}) do
    Reward.changeset(reward, attrs)
  end

  alias Misobo.Rewards.RewardCode

  @doc """
  Returns the list of reward_codes.

  ## Examples

      iex> list_reward_codes()
      [%RewardCode{}, ...]

  """
  def list_reward_codes do
    Repo.all(RewardCode)
  end

  @doc """
  Gets a single reward_code.

  Raises `Ecto.NoResultsError` if the Reward code does not exist.

  ## Examples

      iex> get_reward_code!(123)
      %RewardCode{}

      iex> get_reward_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_reward_code!(id), do: Repo.get!(RewardCode, id)

  @doc """
  Creates a reward_code.

  ## Examples

      iex> create_reward_code(%{field: value})
      {:ok, %RewardCode{}}

      iex> create_reward_code(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_reward_code(attrs \\ %{}) do
    %RewardCode{}
    |> RewardCode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a reward_code.

  ## Examples

      iex> update_reward_code(reward_code, %{field: new_value})
      {:ok, %RewardCode{}}

      iex> update_reward_code(reward_code, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_reward_code(%RewardCode{} = reward_code, attrs) do
    reward_code
    |> RewardCode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a reward_code.

  ## Examples

      iex> delete_reward_code(reward_code)
      {:ok, %RewardCode{}}

      iex> delete_reward_code(reward_code)
      {:error, %Ecto.Changeset{}}

  """
  def delete_reward_code(%RewardCode{} = reward_code) do
    Repo.delete(reward_code)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking reward_code changes.

  ## Examples

      iex> change_reward_code(reward_code)
      %Ecto.Changeset{data: %RewardCode{}}

  """
  def change_reward_code(%RewardCode{} = reward_code, attrs \\ %{}) do
    RewardCode.changeset(reward_code, attrs)
  end

  def redeem_reward(user_id, %Reward{karma: karma, id: reward_id}) do
    Repo.transaction(fn ->
      # update user in reward_codes
      with %RewardCode{is_active: true} = reward_code <- fetch_codes_for_reward(reward_id),
           {:ok, %RewardCode{is_active: false}} <-
             update_reward_code(reward_code, %{user_id: user_id, is_active: false}),
           # reduce karma points basically
           {:ok, %User{}} <-
             Misobo.Accounts.deduct_karma(
               user_id,
               karma,
               "REDEEM:#{reward_id}"
             ) do
        reward_code
      else
        nil ->
          {:error, "Rewards Not available anymore"}

        {:error, changeset} ->
          error =
            Ecto.Changeset.traverse_errors(changeset, &MisoboWeb.ErrorHelpers.translate_error/1)

          Repo.rollback(error)

          {:error, error}
      end
    end)
  end

  def fetch_codes_for_reward(reward_id) do
    query =
      from u in RewardCode,
        select: u,
        where:
          u.reward_id == ^reward_id and
            u.is_active == ^true and
            u.valid_from <= ^DateTime.utc_now() and
            u.valid_upto >= ^DateTime.utc_now(),
        limit: 1

    Repo.one(query)
  end

  def redeemed_rewards(id) do
    query =
      from u in RewardCode,
        where: u.user_id == ^id,
        join: r in Reward,
        on: r.id == u.reward_id,
        select: %{
          redeemed_on: u.redeemed_on,
          valid_from: u.valid_from,
          valid_upto: u.valid_upto,
          user_id: u.user_id,
          code: u.code,
          reward: %{
            id: u.reward_id,
            company_logo: r.company_logo,
            how_to_redeem: r.how_to_redeem,
            img: r.img,
            karma: r.karma,
            offer_details: r.offer_details,
            people_unlocked: r.people_unlocked,
            terms_and_conditions: r.terms_and_conditions,
            title: r.title,
            is_active: r.is_active
          }
        }

    Repo.all(query)
  end
end
